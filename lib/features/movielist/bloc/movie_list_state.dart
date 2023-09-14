// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'movie_list_bloc.dart';

@immutable
sealed class MovieListState {}

sealed class MovieListActionState extends MovieListState {}

class MovieListInitial extends MovieListState {}

class MovieListSuccessState extends MovieListState {}

class MovieListLoadingState extends MovieListState {}

class MovieListLoadedState extends MovieListState {
  final List<MovieModel> movies;

  MovieListLoadedState({
    required this.movies,
  });
}

class MovieListErrorState extends MovieListState {
  final AppErrorType errorType;

  MovieListErrorState(
    this.errorType,
  );
}

class MovieListNavigateToDetailPageState extends MovieListActionState {}
