import 'package:equatable/equatable.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  final Map<String, dynamic> movieDetails;
  final List<Map<String, dynamic>> userReviews;
  final List<Map<String, dynamic>> similarMoviesList;
  final List<Map<String, dynamic>> recommendedMoviesList;
  final List<Map<String, dynamic>> movieTrailersList;

  const MovieDetailLoaded({
    required this.movieDetails,
    required this.userReviews,
    required this.similarMoviesList,
    required this.recommendedMoviesList,
    required this.movieTrailersList,
  });

  @override
  List<Object> get props => [
        movieDetails,
        userReviews,
        similarMoviesList,
        recommendedMoviesList,
        movieTrailersList,
      ];
}

class MovieDetailError extends MovieDetailState {
  final String message;

  const MovieDetailError({required this.message});

  @override
  List<Object> get props => [message];
}
