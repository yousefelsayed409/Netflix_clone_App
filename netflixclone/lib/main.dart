import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflixclone/feature/home/presentation/manger/cubit/movies_cubit.dart';
import 'core/routes/app_routes.dart';
import 'feature/home/presentation/manger/home_cubit/home_cubit.dart';

void main() {
  runApp(const MoveApp());
}

class MoveApp extends StatelessWidget {
  const MoveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeCubit()),
        BlocProvider(create: (_) => MoviesCubit()..getAllMovies()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // theme: ThemeData.dark(),
        themeMode: ThemeMode.dark,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                background: Colors.black, seedColor: Colors.purpleAccent),
            useMaterial3: true),
        onGenerateRoute: AppRoute.generateRoute,
        initialRoute: AppRoute.splashView,
      ),
    );
  }
}
