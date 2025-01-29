import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:netflixclone/feature/home/presentation/view/home_view.dart';
import 'package:netflixclone/feature/details/presentation/view/widget/review-ui.dart';
import 'package:netflixclone/feature/details/presentation/view/widget/trilar_video_moview.dart';
import '../../../../core/utils/text_stule.dart';
import '../../../../core/widget/slider_list.dart';
import '../manger/cubit/movie_detail_cubit.dart';
import '../manger/cubit/movie_detail_state.dart';

class MovieDetailView extends StatelessWidget {
  final int id;
  MovieDetailView(this.id);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieDetailCubit()..fetchMovieDetails(id),
      child: Scaffold(
        body: BlocBuilder<MovieDetailCubit, MovieDetailState>(
          builder: (context, state) {
            if (state is MovieDetailLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.purpleAccent,
                ),
              );
            } else if (state is MovieDetailLoaded) {
              return CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    leading: IconButton(
                      onPressed: () {
                        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
                            overlays: [SystemUiOverlay.bottom]);
                        SystemChrome.setPreferredOrientations([
                          DeviceOrientation.portraitUp,
                          DeviceOrientation.portraitDown,
                        ]);
                        Navigator.pop(context);
                      },
                      icon: const Icon(FontAwesomeIcons.circleArrowLeft),
                      iconSize: 28,
                      color: Colors.white,
                    ),
                    actions: [
                      IconButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeView()),
                            (route) => false,
                          );
                        },
                        icon: const Icon(FontAwesomeIcons.houseUser),
                        iconSize: 25,
                        color: Colors.white,
                      ),
                    ],
                    backgroundColor: const Color.fromRGBO(18, 18, 18, 0.5),
                    centerTitle: false,
                    pinned: true,
                    expandedHeight: MediaQuery.of(context).size.height * 0.4,
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      background: FittedBox(
                        fit: BoxFit.fill,
                        child: Container(
                          child: trailerwatch(
                            trailerytid: state.movieTrailersList.isNotEmpty
                                ? state.movieTrailersList[0]['key']
                                : '',
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 10),
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        state.movieDetails['genres'].length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                              25, 25, 25, 1),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: genrestext(state
                                            .movieDetails['genres'][index]),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  margin:
                                      const EdgeInsets.only(left: 10, top: 10),
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(25, 25, 25, 1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: genrestext(
                                      '${state.movieDetails['runtime']} min'),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 10),
                          child: tittletext('Movie Story:'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 10),
                          child: overviewtext(state.movieDetails['overview']),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 10),
                          child: ReviewUI(revdeatils: state.userReviews),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 20),
                          child: normaltext(
                              'Release Date: ${state.movieDetails['release_date']}'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 20),
                          child: normaltext(
                              'Budget: ${state.movieDetails['budget']}'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 20),
                          child: normaltext(
                              'Revenue: ${state.movieDetails['revenue']}'),
                        ),
                        sliderlist(state.similarMoviesList, "Similar Movies",
                            "movie", state.similarMoviesList.length),
                        sliderlist(
                            state.recommendedMoviesList,
                            "Recommended Movies",
                            "movie",
                            state.recommendedMoviesList.length),
                      ],
                    ),
                  ),
                ],
              );
            } else if (state is MovieDetailError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text('Something went wrong!'));
            }
          },
        ),
      ),
    );
  }
}
