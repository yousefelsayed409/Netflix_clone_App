import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:netflixclone/core/utils/api_keys.dart';

import 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  MovieDetailCubit() : super(MovieDetailInitial());

  Future<void> fetchMovieDetails(int id) async {
    emit(MovieDetailLoading());
    try {
      var moviedetailurl = 'https://api.themoviedb.org/3/movie/$id?api_key=${ApiKeys.apikey}';
      var userReviewUrl = 'https://api.themoviedb.org/3/movie/$id/reviews?api_key=${ApiKeys.apikey}';
      var similarMoviesUrl = 'https://api.themoviedb.org/3/movie/$id/similar?api_key=${ApiKeys.apikey}';
      var recommendedMoviesUrl = 'https://api.themoviedb.org/3/movie/$id/recommendations?api_key=${ApiKeys.apikey}';
      var movieTrailersUrl = 'https://api.themoviedb.org/3/movie/$id/videos?api_key=${ApiKeys.apikey}';

      var movieDetailResponse = await http.get(Uri.parse(moviedetailurl));
      var userReviewResponse = await http.get(Uri.parse(userReviewUrl));
      var similarMoviesResponse = await http.get(Uri.parse(similarMoviesUrl));
      var recommendedMoviesResponse = await http.get(Uri.parse(recommendedMoviesUrl));
      var movieTrailersResponse = await http.get(Uri.parse(movieTrailersUrl));

      if (movieDetailResponse.statusCode == 200 &&
          userReviewResponse.statusCode == 200 &&
          similarMoviesResponse.statusCode == 200 &&
          recommendedMoviesResponse.statusCode == 200 &&
          movieTrailersResponse.statusCode == 200) {
        var movieDetailJson = jsonDecode(movieDetailResponse.body);
        var userReviewJson = jsonDecode(userReviewResponse.body);
        var similarMoviesJson = jsonDecode(similarMoviesResponse.body);
        var recommendedMoviesJson = jsonDecode(recommendedMoviesResponse.body);
        var movieTrailersJson = jsonDecode(movieTrailersResponse.body);

        Map<String, dynamic> movieDetails = {
          "backdrop_path": movieDetailJson['backdrop_path'] ?? '',
          "title": movieDetailJson['title'] ?? '',
          "vote_average": movieDetailJson['vote_average'].toString(),
          "overview": movieDetailJson['overview'] ?? '',
          "release_date": movieDetailJson['release_date'] ?? '',
          "runtime": movieDetailJson['runtime'].toString(),
          "budget": movieDetailJson['budget'].toString(),
          "revenue": movieDetailJson['revenue'].toString(),
          "genres": List<String>.from(movieDetailJson['genres'].map((e) => e['name'].toString())),
        };

        List<Map<String, dynamic>> userReviews = [];
        for (var review in userReviewJson['results']) {
          userReviews.add({
            "name": review['author'] ?? '',
            "review": review['content'] ?? '',
            "rating": review['author_details']['rating']?.toString() ?? "Not Rated",
            "avatarphoto": review['author_details']['avatar_path'] == null
                ? "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png"
                : "https://image.tmdb.org/t/p/w500" + review['author_details']['avatar_path'],
            "creationdate": review['created_at']?.substring(0, 10) ?? '',
            "fullreviewurl": review['url'] ?? '',
          });
        }

        List<Map<String, dynamic>> similarMoviesList = [];
        for (var movie in similarMoviesJson['results']) {
          similarMoviesList.add({
            "poster_path": movie['poster_path'] ?? '',
            "name": movie['title'] ?? '',
            "vote_average": movie['vote_average'].toString(),
            "Date": movie['release_date'] ?? '',
            "id": movie['id'].toString(),
          });
        }

        List<Map<String, dynamic>> recommendedMoviesList = [];
        for (var movie in recommendedMoviesJson['results']) {
          recommendedMoviesList.add({
            "poster_path": movie['poster_path'] ?? '',
            "name": movie['title'] ?? '',
            "vote_average": movie['vote_average'].toString(),
            "Date": movie['release_date'] ?? '',
            "id": movie['id'].toString(),
          });
        }

        List<Map<String, dynamic>> movieTrailersList = [];
        for (var trailer in movieTrailersJson['results']) {
          if (trailer['type'] == "Trailer") {
            movieTrailersList.add({
              "key": trailer['key'] ?? '',
            });
          }
        }

        emit(MovieDetailLoaded(
          movieDetails: movieDetails,
          userReviews: userReviews,
          similarMoviesList: similarMoviesList,
          recommendedMoviesList: recommendedMoviesList,
          movieTrailersList: movieTrailersList,
        ));
      } else {
        emit(MovieDetailError(message: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(MovieDetailError(message: e.toString()));
    }
  }
}
