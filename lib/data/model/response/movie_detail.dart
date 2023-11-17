import 'genres.dart';

class Movie{
  final int id;
  final String posterPath;
  final double budget;
  final List<Genres> genresList;
  final String title;
  final String overView;
  final String releaseDate;
  final double popularity;
  Movie({required this.id, required this.title, required this.budget, required this.genresList, required this.overView, required this.popularity, required this.posterPath, required this.releaseDate});
}

