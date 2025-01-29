import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import '../../../../../core/utils/api_keys.dart';
import 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  MoviesCubit() : super(MoviesInitial());

  Future<void> getAllMovies() async {
    try {
      final popularmoviesUrl = await fetchMovies(ApiKeys.popularmoviesUrl);
      final nowplayigmoviesUrl = await fetchMovies(ApiKeys.nowplayigmoviesUrl);
      final tobratedmoviesUrl = await fetchMovies(ApiKeys.tobratedmoviesUrl);
      final upcommingmoviesUrl = await fetchMovies(ApiKeys.upcommingmoviesUrl);
      final popularTvserieslUrl =
          await fetchMovies(ApiKeys.popularTvserieslUrl);
      final tobratedtvSeriesUrl =
          await fetchMovies(ApiKeys.tobratedtvSeriesUrl);
      final ontheairtvSeriesUrl =
          await fetchMovies(ApiKeys.ontheairtvSeriesUrl);

      emit(MoviesLoaded(
        popularMovies: popularmoviesUrl,
        nowPlayingMovies: nowplayigmoviesUrl,
        topRatedMovies: tobratedmoviesUrl,
        popularTvserieslUrl: popularTvserieslUrl,
        ontheairtvSeriesUrl: ontheairtvSeriesUrl,
        tobratedtvSeriesUrl: tobratedtvSeriesUrl,
        upcomingMovies: upcommingmoviesUrl,
      ));
    } catch (e) {
      emit(MoviesError(e.toString()));
    }
  }

  Future<List<Map<String, dynamic>>> fetchMovies(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final tempdata = jsonDecode(response.body);
      final moviesJson = tempdata['results'] as List;
      return moviesJson
          .map((movie) => {
                "name": movie["title"],
                "poster_path": movie["poster_path"],
                "vote_average": movie["vote_average"],
                "Date": movie["release_date"] ?? movie["first_air_date"],
                "id": movie["id"],
              })
          .toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
