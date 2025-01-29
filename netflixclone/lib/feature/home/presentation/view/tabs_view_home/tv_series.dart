import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../manger/cubit/movies_cubit.dart';
import '../../manger/cubit/movies_state.dart';
import 'package:netflixclone/core/widget/slider_list.dart';

class TvSeries extends StatelessWidget {
  const TvSeries({Key? key}) : super(key: key);

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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  sliderlist(state.popularTvserieslUrl, 'Popular TV Series',
                      'tv', state.popularMovies.length),
                  sliderlist(state.tobratedtvSeriesUrl, 'Top Rated TV Series',
                      'tv', state.tobratedtvSeriesUrl.length),
                  sliderlist(state.ontheairtvSeriesUrl, 'On Air TV Series',
                      'tv', state.ontheairtvSeriesUrl.length),
                ],
              ),
            );
            // CustomScrollView(
            //   physics: const BouncingScrollPhysics(),
            //   slivers: [
            //     SliverToBoxAdapter(
            //       child: Column(
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         children: [
            //           sliderlist(state.popularMovies, 'Popular TV Series', 'tv',
            //               state.popularMovies.length),
            //           sliderlist(
            //               state.tobratedtvSeriesUrl,
            //               'Top Rated TV Series',
            //               'tv',
            //               state.tobratedtvSeriesUrl.length),
            //           sliderlist(state.ontheairtvSeriesUrl, 'On Air TV Series',
            //               'tv', state.ontheairtvSeriesUrl.length),
            //         ],
            //       ),
            //     ),
            //   ],
            // );
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
