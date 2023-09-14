// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:pfc_assignment/data/sources/movie_data_source.dart';

import '../core/app_error.dart';
import '../model/movie_model.dart';

class MovieRepository {
  final MovieDataSource _remote;
  // final MovieDataSource _local;

  MovieRepository(this._remote);

  Future<dynamic> fetchMovies() async {
    try {
      final movies = await _remote.getMovies();
      return movies;
    } on SocketException {
      return const AppError(AppErrorType.network);
    } on Exception {
      return const AppError(AppErrorType.api);
    }
  }

  Future<dynamic> fetchMovieDetail(int id) async {
    try {
      final movies = await _remote.getMovieDetail(id);
      return movies;
    } on SocketException {
      return const AppError(AppErrorType.network);
    } on Exception {
      return const AppError(AppErrorType.api);
    }
  }

  Future<dynamic> fetchMovieWithPage(int id) async {
    try {
      final movies = await _remote.getMoviesAccordingToPage(id);
      return movies;
    } on SocketException {
      return const AppError(AppErrorType.network);
    } on Exception {
      return const AppError(AppErrorType.api);
    }
  }
}
