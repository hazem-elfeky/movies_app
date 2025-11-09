part of 'genre_bloc.dart';

class GenreState {
  final List<GenreEntity> genres;
  final RequestState requestState;
  final String? errorMessage;

  GenreState({
    required this.genres,
    required this.requestState,
    this.errorMessage,
  });

  factory GenreState.initial() {
    return GenreState(
      genres: [],
      requestState: RequestState.loading,
      errorMessage: null,
    );
  }

  GenreState copyWith({
    List<GenreEntity>? genres,
    RequestState? requestState,
    String? errorMessage,
  }) {
    return GenreState(
      genres: genres ?? this.genres,
      requestState: requestState ?? this.requestState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
