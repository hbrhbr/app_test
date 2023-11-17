import 'package:app_test/view/screens/Watch/widgets/movie_thumbnail_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:app_test/controller/movie_controller.dart';
import 'package:app_test/util/app_strings.dart';
import 'package:app_test/util/color_constants.dart';
import 'package:app_test/util/images.dart';
import 'package:app_test/util/styles.dart';
import 'package:app_test/view/base/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/model/response/movie_thumbnail.dart';

class WatchScreen extends StatefulWidget {
  const WatchScreen({Key? key}) : super(key: key);

  @override
  State<WatchScreen> createState() => _WatchScreenState();
}

class _WatchScreenState extends State<WatchScreen>{

  bool isFetchingData = true;
  bool isFetchingNextPageData = false;
  String errorMessage = '';
  RefreshController refreshController = RefreshController();

  @override
  void initState() {
    debugPrint("initState of Watch Screen");
    fetchData();
    super.initState();
  }

  @override
  void dispose() {
    debugPrint("dispose of Watch Screen");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Container(
          height: kToolbarHeight + 50,
          padding: const EdgeInsets.only(bottom: 24, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                AppString.watch,
                style: poppinsMedium,
              ),
              InkWell(
                onTap: () {

                },
                child: Image.asset(Images.search, height: 18, width: 18,),
              ),
            ],
          ),
        ),
        const Divider(height: 1, thickness: 1, color: AppColor.appBarDividerColor,),
        Expanded(
            child: Container(
              width: context.width,
              color: AppColor.appBarDividerColor,
              child: SmartRefresher(
                controller: refreshController,
                header: const MaterialClassicHeader(),
                physics: const RangeMaintainingScrollPhysics(),
                onRefresh: ()async{
                  await fetchData(isRefresh: true);
                },
                onLoading: ()async{
                  setState(() {
                    isFetchingNextPageData = true;
                  });
                  await fetchData();
                  if(mounted){
                    setState(() {
                      isFetchingNextPageData = false;
                    });
                  }
                },
                enablePullDown: !isFetchingNextPageData,
                enableTwoLevel: !refreshController.isRefresh && !isFetchingNextPageData,
                enablePullUp: !refreshController.isRefresh,
                footer: CustomFooter(
                  builder: (BuildContext context, LoadStatus? mode) {
                    return const SizedBox();
                  }
                ),
                child: SizedBox(
                  child: isFetchingData
                      ? const Center(
                        child: CustomLoader(),
                      )
                      : GetBuilder<MovieController>(
                      builder: (MovieController movieController) {
                        if(movieController.moviesList.isNotEmpty){
                          return ListView.builder(
                            padding: const EdgeInsets.only(top: 10),
                            itemCount: movieController.moviesList.length,
                            shrinkWrap: true,
                            physics: const RangeMaintainingScrollPhysics(),
                            itemBuilder: (BuildContext listContext, int index,){
                              MovieThumbnail movieThumbnail = movieController.moviesList[index];
                              return Column(
                                children: [
                                  MovieThumbnailWidget(movieThumbnail: movieThumbnail),
                                  if(isFetchingNextPageData && index==movieController.moviesList.length-1)...[
                                    const CustomLoader(),
                                    const SizedBox(height: 25,),
                                  ]
                                ],
                              );
                            },
                          );
                        }else{
                          return Center(child: Text(errorMessage));
                        }
                      }
                  ),
                ),
              ),
            )
        ),
      ],
    );
  }

  Future<void> fetchData({bool isRefresh = false}) async {
    errorMessage = '';
    MovieController movieController = Get.find<MovieController>();
    errorMessage = await movieController.fetchMoviesList(isRefresh: isRefresh);
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