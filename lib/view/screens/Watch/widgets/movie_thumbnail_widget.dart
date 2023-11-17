import 'package:app_test/data/model/response/movie_thumbnail.dart';
import 'package:app_test/util/app_constants.dart';
import 'package:app_test/util/styles.dart';
import 'package:app_test/view/base/custom_loader.dart';
import 'package:app_test/view/screens/MovieDetail/moview_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

class MovieThumbnailWidget extends StatelessWidget {
  final MovieThumbnail movieThumbnail;
  const MovieThumbnailWidget({Key? key, required this.movieThumbnail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double devicePixel = MediaQuery.of(context).devicePixelRatio*2;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: AspectRatio(
        aspectRatio: 1.8611,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: (){
              Get.to(()=> MovieDetailsScreen(movieId: movieThumbnail.id));
            },
            radius: 10,
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    key: Key("w780${movieThumbnail.imagePath}"),
                    imageUrl: "${AppConstants.imageBaseUrl}w780${movieThumbnail.imagePath}",
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                    width: context.width,
                    maxWidthDiskCache: (context.height * 1.8611 * devicePixel).toInt(),
                    maxHeightDiskCache:  ((context.width / 1.8611) * devicePixel).toInt(),
                    placeholder: (a, data){
                      return const Center(child: CustomLoader());
                    },
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: context.width,
                    padding: const EdgeInsets.all(20),
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
                    child: Text(
                      movieThumbnail.title,
                      textAlign: TextAlign.start,
                      style: poppinsMedium.copyWith(
                        color: Colors.white,
                        fontSize: 18
                      ),
                    )
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
