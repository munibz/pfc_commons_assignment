part of 'movie_detail_bloc.dart';

@immutable
sealed class MovieDetailState {}

sealed class MovieDetailActionState extends MovieDetailState {}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoadingState extends MovieDetailState {}

class MovieDetailLoadedState extends MovieDetailState {
  final MovieDetailModel movieDetail;

  MovieDetailLoadedState({
    required this.movieDetail,
  });
}

class MovieDetailErrorState extends MovieDetailState {
  final AppErrorType errorType;

  MovieDetailErrorState(
    this.errorType,
  );
}
