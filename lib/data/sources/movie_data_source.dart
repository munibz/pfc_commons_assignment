import 'package:pfc_assignment/data/repository/movie_repository.dart';
import 'package:pfc_assignment/di/get_it.dart';

import '../model/movie_detail_model.dart';
import '../model/movie_model.dart';

abstract class MovieDataSource {
  Future<List<MovieModel>> getMovies();
  Future<MovieDetailModel> getMovieDetail(int id);
  Future<List<MovieModel>> getMoviesAccordingToPage(int page);
}
