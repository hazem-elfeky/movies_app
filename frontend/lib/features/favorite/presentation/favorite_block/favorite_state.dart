import 'package:equatable/equatable.dart';
import 'package:my_movies/core/widgets/handling_data_request.dart';
import 'package:my_movies/features/movie/domain/entities/movie_entity.dart';

class FavoriteState extends Equatable {
  final List<MovieEntity> favorites;
  final RequestState requestState;
  final String? errorMessage;

  const FavoriteState({
    this.favorites = const [],
    this.requestState = RequestState.loading,
    this.errorMessage,
  });

  FavoriteState copyWith({
    List<MovieEntity>? favorites,
    RequestState? requestState,
    String? errorMessage,
  }) {
    return FavoriteState(
      favorites: favorites ?? this.favorites,
      requestState: requestState ?? this.requestState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [favorites, requestState, errorMessage];
}
