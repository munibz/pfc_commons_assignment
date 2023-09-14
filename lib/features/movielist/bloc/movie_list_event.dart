// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'movie_list_bloc.dart';

@immutable
sealed class MovieListEvent {}

class MovieListInitialEvent extends MovieListEvent {
  final int page;
  final PagingController pageController;

  MovieListInitialEvent({
    required this.page,
    required this.pageController,
  });
}

class MovieListFetchNextPageEvent extends MovieListEvent {
  final int page;
  final PagingController pageController;

  MovieListFetchNextPageEvent({
    required this.page,
    required this.pageController,
  });
}

class MovieListTileClickedNavigateEvent extends MovieListEvent {}
