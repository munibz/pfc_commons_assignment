// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:pfc_assignment/data/model/movie_detail_model.dart';
import '../../../data/core/app_error.dart';
import '../../../data/repository/movie_repository.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final MovieRepository repository;

  MovieDetailBloc({
    required this.repository,
  }) : super(MovieDetailInitial()) {
    on<MovieDetailEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<MovieDetailInitialEvent>(movieDetailInitialEvent);
  }

  FutureOr<void> movieDetailInitialEvent(
      MovieDetailInitialEvent event, Emitter<MovieDetailState> emit) async {
    emit(MovieDetailLoadingState());
    final result = await repository.fetchMovieDetail(event.movieId);

    if (result is AppError) {
      emit(MovieDetailErrorState(result.appErrorType));
    } else if (result is MovieDetailModel) {
      emit(MovieDetailLoadedState(movieDetail: result));
    }
  }
}
