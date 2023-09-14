// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'movie_detail_bloc.dart';

@immutable
sealed class MovieDetailEvent {}

class MovieDetailInitialEvent extends MovieDetailEvent {
  final int movieId;
  MovieDetailInitialEvent({
    required this.movieId,
  });
}
