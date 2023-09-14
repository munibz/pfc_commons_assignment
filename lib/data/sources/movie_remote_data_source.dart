import 'package:pfc_assignment/data/sources/movie_data_source.dart';

import '../model/movie_detail_model.dart';
import '../model/movie_model.dart';
import '../model/movie_result_model.dart';
import '../core/api_client.dart';

class MovieRemoteDataSource implements MovieDataSource {
  final ApiClient _client;

  MovieRemoteDataSource(this._client);

  @override
  Future<List<MovieModel>> getMovies() async {
    final response = await _client.get('trending/movie/day');
    final movies = MoviesResultModel.fromJson(response).movies;

    print(movies.toString());
    return movies!;
  }

  @override
  Future<List<MovieModel>> getMoviesAccordingToPage(int page) async {
    final response = await _client.get('trending/movie/day', params: {
      'page': page,
    });

    final movies = MoviesResultModel.fromJson(response).movies;
    print(movies.toString());
    return movies!;
  }

  @override
  Future<MovieDetailModel> getMovieDetail(int id) async {
    final response = await _client.get('movie/$id');
    final movie = MovieDetailModel.fromJson(response);
    print(movie.toString());
    return movie;
  }
}
