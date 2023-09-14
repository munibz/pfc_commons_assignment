// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

import 'movie_model.dart';

class MoviesResultModel {
  List<MovieModel>? movies;

  MoviesResultModel({
    this.movies,
  });

  factory MoviesResultModel.fromJson(Map<String, dynamic> json) {
    var movies = List<MovieModel>.empty(growable: true);
    if (json['results'] != null) {
      json['results'].forEach((v) {
        final movieModel = MovieModel.fromJson(v);
        movies.add(movieModel);
      });
    }

    return MoviesResultModel(movies: movies);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (movies != null) {
      data['results'] = movies!.map((v) => v.toJson()).toList();
    }

    return data;
  }

  @override
  bool operator ==(covariant MoviesResultModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.movies, movies);
  }

  @override
  int get hashCode => movies.hashCode;
}
