import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:netflixclone/feature/home/presentation/view/home_view.dart';
import 'package:netflixclone/feature/home/presentation/view/tabs_view_home/movie.dart';
import 'package:netflixclone/feature/home/presentation/view/tabs_view_home/tv_series.dart';
import 'package:netflixclone/feature/home/presentation/view/tabs_view_home/up_coming.dart';
import 'package:netflixclone/feature/home/presentation/view/widget/searchbar_widget.dart';

class BottomNavBarWidget extends StatelessWidget {
  const BottomNavBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          bottomNavigationBar: Container(
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.transparent,
            ),
            child: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.home),
                  text: 'Home',
                ),
                Tab(
                  icon: Icon(Icons.search),
                  text: 'search',
                ),
              ],
              indicatorColor: Colors.purple,
              labelColor: Colors.white,
              unselectedLabelColor: Color(0xff999999),
            ),
          ),
          body: TabBarView(children: [
            HomeView(),
            SearchBarFun(),
          ]),
        ));
  }
}
