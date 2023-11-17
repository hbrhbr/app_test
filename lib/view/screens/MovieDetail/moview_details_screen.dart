import 'package:app_test/helper/helper.dart';
import 'package:app_test/view/base/custom_button.dart';
import 'package:intl/intl.dart';
import 'package:app_test/data/model/response/movie_detail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:app_test/controller/movie_controller.dart';
import 'package:app_test/util/color_constants.dart';
import 'package:app_test/util/styles.dart';
import 'package:app_test/view/base/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/model/response/genres.dart';
import '../../../util/app_constants.dart';
import '../../../util/app_strings.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int movieId;
  const MovieDetailsScreen({Key? key, required this.movieId}) : super(key: key);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen>{

  bool isFetchingData = true;
  bool isFetchingNextPageData = false;
  String errorMessage = '';
  RefreshController refreshController = RefreshController();

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  void dispose() {
    Get.find<MovieController>().disposeCurrentMovie();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double devicePixel = MediaQuery.of(context).devicePixelRatio*2;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,

        children: [
          Container(
            width: context.width,
            color: AppColor.appBarDividerColor,
            child: SizedBox(
              child: isFetchingData
                  ? const Center(
                child: CustomLoader(),
              )
                  : GetBuilder<MovieController>(
                  builder: (MovieController movieController) {
                    if(movieController.currentlyViewingMovie!=null){
                      Movie movie = movieController.currentlyViewingMovie!;
                      return ListView(
                        padding: const EdgeInsets.all(0),
                        children: [
                          SizedBox(
                            height: context.height*0.7,
                            child: Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                CachedNetworkImage(
                                  imageUrl: "${AppConstants.imageBaseUrl}original${movie.posterPath}",
                                  key: Key("original${movie.posterPath}"),
                                  fit: BoxFit.cover,
                                  filterQuality: FilterQuality.high,
                                  width: context.width,
                                  maxWidthDiskCache: (context.height * 1.8611 * devicePixel).toInt(),
                                  maxHeightDiskCache:  (context.width * devicePixel).toInt(),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    height: 380,
                                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 34),
                                    width: context.width,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          const Color(0xFF000000).withOpacity(0.7),
                                          Colors.transparent,
                                        ],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          'In theaters ${getFormattedDate(movie.releaseDate)}',
                                          style: poppinsMedium.copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        CustomButton(
                                          onPressed: (){},
                                          buttonText: 'Get Tickets',
                                          height: 50,
                                          fontSize: 14,
                                          color: AppColor.skyBlue,
                                        ),
                                        const SizedBox(height:15),
                                        CustomButton(
                                          onPressed: (){
                                            watchTrailer(movie.id);
                                          },
                                          buttonText: 'Watch Trailer',
                                          height: 50,
                                          fontSize: 14,
                                          color: Colors.transparent,
                                          icon: Icons.play_arrow_rounded,
                                          boxDecoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(color: AppColor.skyBlue)
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: ListView(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                Text(
                                  'Genres',
                                  style: poppinsMedium.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 14,),
                                SizedBox(
                                  height: 24,
                                  width: context.width,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: movie.genresList.length,
                                    itemBuilder: (BuildContext listContext, int index){
                                      Genres genres = movie.genresList[index];
                                      return Container(
                                        height: 24,
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        decoration: BoxDecoration(
                                          color: AppColor.genresColors[index%4],
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        margin: const EdgeInsets.only(right: 5),
                                        child: Center(
                                          child: Text(
                                            genres.name,
                                            style: poppinsMedium.copyWith(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 24,),
                                Divider(color: Colors.black.withOpacity(0.1),),
                                const SizedBox(height: 14,),
                                Text(
                                  'Overview',
                                  style: poppinsMedium.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 14,),
                                Text(
                                  movie.overView,
                                  style: poppinsRegular.copyWith(
                                      fontSize: 12,
                                      color: const Color(0xFF8F8F8F)
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30,),
                        ],
                      );
                    }else{
                      return Center(child: Text(errorMessage));
                    }
                  }
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              height: kToolbarHeight + 50,
              margin: const EdgeInsets.only(bottom: 24, left: 20, right: 20,top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(onPressed: (){Get.back();}, icon: const Icon(Icons.arrow_back_ios),color: Colors.white,),
                  Text(
                    AppString.watch,
                    style: poppinsMedium.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> fetchData({bool isRefresh = false}) async {
    errorMessage = '';
    MovieController movieController = Get.find<MovieController>();
    errorMessage = await movieController.fetchMovieDetails(movieId: widget.movieId);
    isFetchingData = false;
    if(refreshController.isLoading){
      refreshController.loadComplete();
    }else if(refreshController.isRefresh){
      refreshController.refreshCompleted();
    }
    if(mounted){
      setState(() {});
    }
  }

}