import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widget/slider_list.dart';
import '../../manger/cubit/movies_cubit.dart';
import '../../manger/cubit/movies_state.dart';

class Movie extends StatelessWidget {
  const Movie({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MoviesCubit, MoviesState>(
        builder: (context, state) {
          if (state is MoviesLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.purpleAccent,
              ),
            );
          } else if (state is MoviesLoaded) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  sliderlist(state.popularMovies, 'Popular Movies', 'movie',
                      state.popularMovies.length),
                  sliderlist(state.nowPlayingMovies, 'Now Playing', 'movie',
                      state.nowPlayingMovies.length),
                  sliderlist(state.topRatedMovies, 'Top Rated Movies', 'movie',
                      state.topRatedMovies.length),
                ],
              ),
            );
          } else if (state is MoviesError) {
            return Center(
              child: Text('Error: ${state.error}'),
            );
          } else {
            return const Center(
              child: Text('Unknown state'),
            );
          }
        },
      ),
    );
  }
}
