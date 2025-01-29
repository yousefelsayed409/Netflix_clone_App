import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../manger/cubit/movies_cubit.dart';
import '../../manger/cubit/movies_state.dart';
import 'package:netflixclone/core/widget/slider_list.dart';

class UpComing extends StatelessWidget {
  const UpComing({Key? key}) : super(key: key);

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
            return CustomScrollView(
              physics: const NeverScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      sliderlist(state.upcomingMovies, 'Upcoming Movies',
                          'upcoming', state.upcomingMovies.length),
                    ],
                  ),
                ),
              ],
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
