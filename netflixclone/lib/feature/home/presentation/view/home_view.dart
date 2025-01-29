import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:netflixclone/core/utils/app_assets.dart';
import 'package:netflixclone/core/utils/app_colors.dart';
import 'package:netflixclone/core/utils/app_style.dart';
import 'package:netflixclone/feature/home/presentation/view/widget/searchbar_widget.dart';
import 'package:netflixclone/feature/home/presentation/view/tabs_view_home/movie.dart';
import 'package:netflixclone/feature/home/presentation/view/tabs_view_home/tv_series.dart';
import 'package:netflixclone/feature/home/presentation/view/tabs_view_home/up_coming.dart';
import '../manger/home_cubit/home_cubit.dart';
import '../manger/home_cubit/home_state.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  int val = 1;
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    context.read<HomeCubit>().fetchTrendingList(val);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          AppAssets.logo,
          height: 20,
          width: 100,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return SearchBarFun();
                }));
              },
              icon: const Icon(
                Icons.search,
                color: AppColors.white,
              )),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Container(
              color: AppColors.blue,
              height: 27,
              width: 27,
            ),
          )
        ],
        backgroundColor: Colors.black,
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.black,
            toolbarHeight: 40,
            expandedHeight: MediaQuery.of(context).size.height * 0.4,
            centerTitle: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.purpleAccent,
                      ),
                    );
                  } else if (state is HomeLoaded) {
                    return CarouselSlider(
                      items: state.movies.map((i) {
                        return Builder(builder: (BuildContext context) {
                          return GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.3),
                                    BlendMode.darken,
                                  ),
                                  image: NetworkImage(
                                    'https://image.tmdb.org/t/p/w500${i['poster_path']}',
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          );
                        });
                      }).toList(),
                      options: CarouselOptions(
                        height: MediaQuery.of(context).size.height,
                        aspectRatio: 16 / 9,
                        viewportFraction: 1,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.3,
                        scrollDirection: Axis.horizontal,
                      ),
                    );
                  } else if (state is HomeError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Trending 🔥',
                  style: AppTextStyles.tstyle16,
                ),
                const SizedBox(width: 5),
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: DropdownButton(
                      value: val,
                      onChanged: (value) {
                        setState(() {
                          val = int.parse(value.toString());
                          context.read<HomeCubit>().fetchTrendingList(val);
                        });
                      },
                      autofocus: true,
                      dropdownColor: Colors.black.withOpacity(0.6),
                      icon: const Icon(
                        Icons.arrow_drop_down_sharp,
                        color: Colors.purpleAccent,
                      ),
                      items: [
                        DropdownMenuItem(
                          value: 1,
                          child: Text(
                            'Weekly',
                            style: AppTextStyles.tstyle16,
                          ),
                        ),
                        DropdownMenuItem(
                          value: 2,
                          child: Text(
                            'Daily',
                            style: AppTextStyles.tstyle16,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 10),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 45,
                  child: Center(
                    child: TabBar(
                      dividerColor: AppColors.puplar,
                      labelPadding: const EdgeInsets.symmetric(horizontal: 20),
                      controller: tabController,
                      isScrollable: true,
                      physics: const BouncingScrollPhysics(),
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        // color: Colors.purpleAccent,
                      ),
                      tabs: const [
                        Tab(child: Text('Movie')),
                        Tab(child: Text('Tv Series')),
                        Tab(child: Text('UpComing')),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.black,
                  height: MediaQuery.of(context).size.height - 20,
                  child: TabBarView(
                    controller: tabController,
                    children: const [
                      Movie(),
                      TvSeries(),
                      UpComing(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
