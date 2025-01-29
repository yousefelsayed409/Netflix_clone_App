import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:netflixclone/feature/home/presentation/manger/home_cubit/home_cubit.dart';
import '../../manger/home_cubit/home_state.dart';
import 'package:netflixclone/core/utils/text_stule.dart';
import 'package:netflixclone/feature/details/presentation/view/movie_view.dart'; // استبدال بالمسار الفعلي

class SearchBarFun extends StatefulWidget {
  const SearchBarFun({super.key});

  @override
  State<SearchBarFun> createState() => _SearchBarFunState();
}

class _SearchBarFunState extends State<SearchBarFun> {
  final TextEditingController searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10.0, top: 30, bottom: 20, right: 10),
          child: Column(
            children: [
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: TextField(
                  autofocus: false,
                  controller: searchTextController,
                  onSubmitted: (value) {
                    context.read<HomeCubit>().searchMoviesAndTvShows(value);
                  },
                  onChanged: (value) {
                    context.read<HomeCubit>().searchMoviesAndTvShows(value);
                  },
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        Fluttertoast.showToast(
                          webBgColor: "#000000",
                          webPosition: "center",
                          webShowClose: true,
                          msg: "Search Cleared",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 2,
                          backgroundColor: const Color.fromRGBO(18, 18, 18, 1),
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                        searchTextController.clear();
                        context.read<HomeCubit>().clearSearch();
                      },
                      icon: Icon(
                        Icons.clear_sharp,
                        color: Colors.purpleAccent.withOpacity(0.6),
                      ),
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.purpleAccent,
                    ),
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return const Center(
                      child:
                          CircularProgressIndicator(color: Colors.purpleAccent),
                    );
                  } else if (state is SearchLoaded) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: state.searchResults.length,
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final result = state.searchResults[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MovieDetailView(result['id']),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              height: 180,
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(20, 20, 20, 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          'https://image.tmdb.org/t/p/w500${result['poster_path']}',
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        tittletext(result['media_type']),
                                        Row(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(5),
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color: Colors.amber
                                                    .withOpacity(0.2),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(6)),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Icon(Icons.star,
                                                      color: Colors.amber,
                                                      size: 20),
                                                  const SizedBox(width: 5),
                                                  ratingtext(
                                                      '${result['vote_average']}'),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Container(
                                              padding: const EdgeInsets.all(5),
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color: Colors.amber
                                                    .withOpacity(0.2),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(8)),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Icon(
                                                      Icons
                                                          .people_outline_sharp,
                                                      color: Colors.amber,
                                                      size: 20),
                                                  const SizedBox(width: 5),
                                                  ratingtext(
                                                      '${result['popularity']}'),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          height: 85,
                                          child: Text(
                                            result['overview'],
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.white),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 4,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else if (state is SearchError) {
                    return Center(child: Text('Error: ${state.error}'));
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
