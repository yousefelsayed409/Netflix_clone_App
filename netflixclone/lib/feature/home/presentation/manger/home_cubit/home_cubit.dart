import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:netflixclone/core/utils/api_keys.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  void fetchTrendingList(int val) async {
    emit(HomeLoading());
    try {
      final String url =
          (val == 1) ? ApiKeys.trandingweekUrl : ApiKeys.trandingdayUrl;
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<Map<String, dynamic>> movies = [];
        for (var item in data['results']) {
          movies.add({
            'id': item['id'],
            'poster_path': item['poster_path'],
            'vote_average': item['vote_average'],
            'media_type': item['media_type'],
            'indexno': movies.length,
          });
        }
        emit(HomeLoaded(movies));
      } else {
        emit(const HomeError('Failed to load movies'));
      }
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> searchMoviesAndTvShows(String query) async {
    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());

    try {
      final searchUrl =
          'https://api.themoviedb.org/3/search/multi?api_key=${ApiKeys.apikey}&query=$query';
      final response = await http.get(Uri.parse(searchUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final searchResults = List<Map<String, dynamic>>.from(data['results']
            .map((item) => {
                  'id': item['id'],
                  'poster_path': item['poster_path'],
                  'vote_average': item['vote_average'],
                  'media_type': item['media_type'],
                  'popularity': item['popularity'],
                  'overview': item['overview'],
                })
            .where((item) =>
                item['id'] != null &&
                item['poster_path'] != null &&
                item['vote_average'] != null &&
                item['media_type'] != null));

        emit(SearchLoaded(searchResults));
        if (searchResults.length > 20) {
          searchResults.removeRange(20, searchResults.length);
        }
      } else {
        emit(SearchError('Failed to load search results'));
      }
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }

  void clearSearch() {
    emit(SearchInitial());
  }
}
