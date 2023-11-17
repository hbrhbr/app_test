import 'dart:async';
import 'package:app_test/data/api/Api_Handler/api_error_response.dart';
import 'package:app_test/data/model/response/genres.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/model/response/movie_detail.dart';
import '../data/model/response/movie_thumbnail.dart';
import '../data/repository/movie_repo.dart';

class MovieController extends GetxController implements GetxService {

  final MovieRepo movieRepo;
  MovieController({required this.movieRepo});

  List<MovieThumbnail> moviesList = <MovieThumbnail>[];
  int pageNumber = 1;
  bool isLastPageFetched = false;
  Movie ?currentlyViewingMovie;

  Future<String> fetchMovieDetails({required int movieId,}) async {
    Map<String,dynamic> response = await movieRepo.fetchMoviesDetails(movieId: movieId,);
    if(response.containsKey(API_RESPONSE.SUCCESS)){
      Map<String, dynamic> result = response[API_RESPONSE.SUCCESS];
      debugPrint("result:-> $result");
      currentlyViewingMovie = Movie(
          id: result['id'],
          title: result['original_title'],
          budget: double.parse('${result['budget']??0.0}'),
          genresList: (result['genres'] as List).map((e) => Genres(id: e['id'], name: e['name'])).toList(),
          overView: result['overview'],
          popularity: result['popularity'],
          posterPath: result['poster_path'] ?? result['backdrop_path'],
          releaseDate: result['release_date']
      );
      return moviesList.isEmpty ? "No movie available" : "";
    }else{
     return response[API_RESPONSE.ERROR]??response[API_RESPONSE.EXCEPTION]??"Something went wrong";
    }
  }
  Future<List> fetchMovieVideos({required int movieId,}) async {
    Map<String,dynamic> response = await movieRepo.fetchMovieVideos(movieId: movieId,);
    if(response.containsKey(API_RESPONSE.SUCCESS)){
      Map<String, dynamic> result = response[API_RESPONSE.SUCCESS];
      debugPrint("result:-> ${result}");
      return result['results'];
    }else{
     return [];
    }
  }
  Future<String> fetchMoviesList({bool isRefresh=false}) async {
    Map<String,dynamic> response = await movieRepo.fetchMoviesList(pageNumber: isRefresh ? 1 : pageNumber);
    if(response.containsKey(API_RESPONSE.SUCCESS)){
      Map<String, dynamic> result = response[API_RESPONSE.SUCCESS];
      if(isRefresh){
        pageNumber = 0;
        moviesList.clear();
        isLastPageFetched = false;
      }else{
        isLastPageFetched = result['total_pages']==pageNumber;
      }
      debugPrint("isLastPageFetched:-> $isLastPageFetched");
      if(!isLastPageFetched){
        pageNumber++;
      }
      List fetchMovies = result['results'];
      for(Map<String, dynamic>movie in fetchMovies){
        moviesList.add(MovieThumbnail(id: movie['id'], title: movie['title'], imagePath: movie['backdrop_path'] ?? movie['poster_path']));
      }
      return moviesList.isEmpty ? "No movie available" : "";
    }else{
     return response[API_RESPONSE.ERROR]??response[API_RESPONSE.EXCEPTION]??"Something went wrong";
    }
  }

  void disposeCurrentMovie(){
    currentlyViewingMovie=null;
    try{
      update();
    }catch(e){}
  }
}