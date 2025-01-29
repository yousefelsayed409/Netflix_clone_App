// part of 'home_cubit.dart';

import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Map<String, dynamic>> movies;

  const HomeLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object> get props => [message];
}

///todo__________SearchState__________ 

class SearchInitial extends HomeState {}

class SearchLoading extends HomeState {}


class SearchLoaded extends HomeState {
  final List<Map<String, dynamic>> searchResults;

  const SearchLoaded(this.searchResults);
}
class SearchError extends HomeState {
  final String error;

  const SearchError(this.error);

}