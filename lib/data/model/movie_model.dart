// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final movieModel = movieModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/foundation.dart';

MovieModel movieModelFromJson(String str) =>
    MovieModel.fromJson(json.decode(str));

String movieModelToJson(MovieModel data) => json.encode(data.toJson());

class MovieModel {
  final bool? adult;
  final String? backdropPath;
  final int? id;
  final String? title;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final String? posterPath;
  final String? mediaType;
  final List<int>? genreIds;
  final double? popularity;
  final DateTime? releaseDate;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;

  MovieModel({
    this.adult,
    this.backdropPath,
    this.id,
    this.title,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.mediaType,
    this.genreIds,
    this.popularity,
    this.releaseDate,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  MovieModel copyWith({
    bool? adult,
    String? backdropPath,
    int? id,
    String? title,
    String? originalLanguage,
    String? originalTitle,
    String? overview,
    String? posterPath,
    String? mediaType,
    List<int>? genreIds,
    double? popularity,
    DateTime? releaseDate,
    bool? video,
    double? voteAverage,
    int? voteCount,
  }) =>
      MovieModel(
        adult: adult ?? this.adult,
        backdropPath: backdropPath ?? this.backdropPath,
        id: id ?? this.id,
        title: title ?? this.title,
        originalLanguage: originalLanguage ?? this.originalLanguage,
        originalTitle: originalTitle ?? this.originalTitle,
        overview: overview ?? this.overview,
        posterPath: posterPath ?? this.posterPath,
        mediaType: mediaType ?? this.mediaType,
        genreIds: genreIds ?? this.genreIds,
        popularity: popularity ?? this.popularity,
        releaseDate: releaseDate ?? this.releaseDate,
        video: video ?? this.video,
        voteAverage: voteAverage ?? this.voteAverage,
        voteCount: voteCount ?? this.voteCount,
      );

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        id: json["id"],
        title: json["title"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        mediaType: json["media_type"],
        genreIds: json["genre_ids"] == null
            ? []
            : List<int>.from(json["genre_ids"]!.map((x) => x)),
        popularity: json["popularity"]?.toDouble(),
        releaseDate: json["release_date"] == null
            ? null
            : DateTime.parse(json["release_date"]),
        video: json["video"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "id": id,
        "title": title,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "poster_path": posterPath,
        "media_type": mediaType,
        "genre_ids":
            genreIds == null ? [] : List<dynamic>.from(genreIds!.map((x) => x)),
        "popularity": popularity,
        "release_date":
            "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  @override
  bool operator ==(covariant MovieModel other) {
    if (identical(this, other)) return true;

    return other.adult == adult &&
        other.backdropPath == backdropPath &&
        other.id == id &&
        other.title == title &&
        other.originalLanguage == originalLanguage &&
        other.originalTitle == originalTitle &&
        other.overview == overview &&
        other.posterPath == posterPath &&
        other.mediaType == mediaType &&
        listEquals(other.genreIds, genreIds) &&
        other.popularity == popularity &&
        other.releaseDate == releaseDate &&
        other.video == video &&
        other.voteAverage == voteAverage &&
        other.voteCount == voteCount;
  }

  @override
  int get hashCode {
    return adult.hashCode ^
        backdropPath.hashCode ^
        id.hashCode ^
        title.hashCode ^
        originalLanguage.hashCode ^
        originalTitle.hashCode ^
        overview.hashCode ^
        posterPath.hashCode ^
        mediaType.hashCode ^
        genreIds.hashCode ^
        popularity.hashCode ^
        releaseDate.hashCode ^
        video.hashCode ^
        voteAverage.hashCode ^
        voteCount.hashCode;
  }

  @override
  String toString() {
    return 'MovieModel(adult: $adult, backdropPath: $backdropPath, id: $id, title: $title, originalLanguage: $originalLanguage, originalTitle: $originalTitle, overview: $overview, posterPath: $posterPath, mediaType: $mediaType, genreIds: $genreIds, popularity: $popularity, releaseDate: $releaseDate, video: $video, voteAverage: $voteAverage, voteCount: $voteCount)';
  }
}
