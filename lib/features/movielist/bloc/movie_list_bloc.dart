import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:meta/meta.dart';
import 'package:pfc_assignment/data/core/app_error.dart';
import 'package:pfc_assignment/data/model/movie_model.dart';

import '../../../data/repository/movie_repository.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final MovieRepository repository;

  MovieListBloc({required this.repository}) : super(MovieListInitial()) {
    on<MovieListEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<MovieListInitialEvent>(movieListInitialEvent);
    on<MovieListTileClickedNavigateEvent>(movieListTileClickedNavigateEvent);
  }

  FutureOr<void> movieListTileClickedNavigateEvent(
      MovieListTileClickedNavigateEvent event, Emitter<MovieListState> emit) {
    print('movieDetailNavigated');

    emit(MovieListNavigateToDetailPageState());
  }

  FutureOr<void> movieListInitialEvent(
      MovieListInitialEvent event, Emitter<MovieListState> emit) async {
    var result;
    const pageSize = 20;

    if (event.page == 1) {
      emit(MovieListLoadingState());
      result = await repository.fetchMovieWithPage(event.page);

      if (result is AppError) {
        emit(MovieListErrorState(result.appErrorType));
      } else if (result is List<MovieModel>) {
        emit(MovieListLoadedState(movies: result));
        addPages(result, pageSize, event);
      }
    } else {
      result = await repository.fetchMovieWithPage(event.page);

      if (result is AppError) {
        event.pageController.error = result.appErrorType;
      } else if (result is List<MovieModel>) {
        addPages(result, pageSize, event);
      }
    }
  }

  void addPages(
      List<MovieModel> newItems, int pageSize, MovieListInitialEvent event) {
    final isLastPage = newItems.length < pageSize;
    if (isLastPage) {
      event.pageController.appendLastPage(newItems);
    } else {
      final nextPage = event.page + 1;
      event.pageController.appendPage(newItems, nextPage);
    }
  }

  FutureOr<void> movieListFetchNextPageEvent(
      MovieListFetchNextPageEvent event, Emitter<MovieListState> emit) async {
    const pageSize = 20;

    var result = await repository.fetchMovieWithPage(event.page);

    final List<MovieModel> newItems = [];

    if (result is AppError) {
      event.pageController.error = result.appErrorType;
    } else if (result is List<MovieModel>) {
      newItems.addAll(result);
      final isLastPage = newItems.length < pageSize;
      if (isLastPage) {
        event.pageController.appendLastPage(newItems);
      } else {
        final nextPage = event.page + 1;
        event.pageController.appendPage(newItems, nextPage);
      }
    }
  }
}
