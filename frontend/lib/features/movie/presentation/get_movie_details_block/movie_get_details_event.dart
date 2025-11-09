import 'package:equatable/equatable.dart';

abstract class MovieGetDetailsEvent extends Equatable {
  const MovieGetDetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchMovieDetailsEvent extends MovieGetDetailsEvent {
  final int movieId;

  const FetchMovieDetailsEvent(this.movieId);

  @override
  List<Object> get props => [movieId];
}
