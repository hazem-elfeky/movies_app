import 'package:equatable/equatable.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object?> get props => [];
}

class FetchFavoritesEvent extends FavoriteEvent {}

class ToggleFavoriteEvent extends FavoriteEvent {
  final int movieId;
  const ToggleFavoriteEvent(this.movieId);

  @override
  List<Object?> get props => [movieId];
}
