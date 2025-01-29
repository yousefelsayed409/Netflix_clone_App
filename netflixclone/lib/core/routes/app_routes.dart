import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflixclone/feature/home/presentation/manger/home_cubit/home_cubit.dart';
import 'package:netflixclone/feature/home/presentation/view/home_view.dart';

import '../../feature/details/presentation/view/movie_view.dart';
import '../../feature/splash/view/splash_view.dart';
import '../widget/bottom_nav_bar_widget.dart';

abstract class AppRoute {
  static const splashView = 'SplashView';
  static const bottomNavBarWidget = 'BottomNavBarWidget';
  // static const signinView = 'SignInView';
  // static const signupView = 'SignUpView';
  static const homeView = 'HomeView';
  static const movieDetailView = 'MovieDetailView';

  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashView:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case bottomNavBarWidget:
        return MaterialPageRoute(builder: (_) => const BottomNavBarWidget());
      // case signupView:
      //   return MaterialPageRoute(
      //       builder: (_) => const SignUpView());
      // case signinView:
      //   return MaterialPageRoute(
      //       builder: (_) => const SignInView());

      case homeView:
        return MaterialPageRoute(builder: (_) => const HomeView());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defind${settings.name}'),
                  ),
                ));
    }
  }
}
