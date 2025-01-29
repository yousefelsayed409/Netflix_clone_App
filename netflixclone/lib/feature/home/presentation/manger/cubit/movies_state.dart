import 'package:meta/meta.dart';

abstract class MoviesState {}

class MoviesInitial extends MoviesState {}

class MoviesLoading extends MoviesState {}

class MoviesLoaded extends MoviesState {
  final List<Map<String, dynamic>> popularMovies;
  final List<Map<String, dynamic>> nowPlayingMovies;
  final List<Map<String, dynamic>> topRatedMovies;
  final List<Map<String, dynamic>> upcomingMovies;
  final List<Map<String, dynamic>> popularTvserieslUrl;
  final List<Map<String, dynamic>> tobratedtvSeriesUrl;
  final List<Map<String, dynamic>> ontheairtvSeriesUrl;

  MoviesLoaded({
    required this.popularMovies,
    required this.nowPlayingMovies,
    required this.topRatedMovies,
    required this.upcomingMovies,
    required this.popularTvserieslUrl,
    required this.tobratedtvSeriesUrl,
    required this.ontheairtvSeriesUrl,
  });
}

class MoviesError extends MoviesState {
  final String error;

  MoviesError(this.error);
}
