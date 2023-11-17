import 'package:app_test/data/api/Api_Handler/api_call_Structure.dart';
import 'package:app_test/data/api/Api_Handler/api_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart' as ApiClient;
import '../../util/app_constants.dart';

class MovieRepo {
  final SharedPreferences sharedPreferences;
  MovieRepo({required this.sharedPreferences});

  Future<Map<String, dynamic>> fetchMoviesList({int pageNumber = 1}) async {
    print("pageNumber:->> $pageNumber");

    API_STRUCTURE apiObject = API_STRUCTURE(
      apiUrl: "${AppConstants.fetchMovies}$pageNumber",
      apiRequestMethod: API_REQUEST_METHOD.GET,
      isWantSuccessMessage: false,
    );
    return await apiObject.requestAPI(isShowLoading: false,);
  }
  Future<Map<String, dynamic>> fetchMoviesDetails({required int movieId}) async {
    print("movieId:->> $movieId");
    API_STRUCTURE apiObject = API_STRUCTURE(
      apiUrl: "$movieId${AppConstants.fetchMovieDetails}",
      apiRequestMethod: API_REQUEST_METHOD.GET,
      isWantSuccessMessage: false,
    );
    return await apiObject.requestAPI(isShowLoading: false,);
  }
  Future<Map<String, dynamic>> fetchMovieVideos({required int movieId}) async {
    print("movieId:->> $movieId");
    API_STRUCTURE apiObject = API_STRUCTURE(
      apiUrl: "$movieId/videos${AppConstants.fetchMovieDetails}",
      apiRequestMethod: API_REQUEST_METHOD.GET,
      isWantSuccessMessage: false,
    );
    return await apiObject.requestAPI(isShowLoading: false,);
  }
}
