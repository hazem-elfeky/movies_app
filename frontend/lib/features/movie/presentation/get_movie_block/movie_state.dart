import 'package:equatable/equatable.dart';
import '../../../../core/widgets/handling_data_request.dart';
import '../../domain/entities/movie_entity.dart';

class MovieState extends Equatable {
  final RequestState requestState;
  final List<MovieEntity> movies;
  final String? errorMessage;
  final String pageTitle;

  const MovieState({
    this.requestState = RequestState.loading,
    this.movies = const [],
    this.errorMessage,
    this.pageTitle = "Movies",
  });

  MovieState copyWith({
    RequestState? requestState,
    List<MovieEntity>? movies,
    String? errorMessage,
    String? pageTitle,
  }) {
    return MovieState(
      requestState: requestState ?? this.requestState,
      movies: movies ?? this.movies,
      errorMessage: errorMessage ?? this.errorMessage,
      pageTitle: pageTitle ?? this.pageTitle,
    );
  }

  @override
  List<Object?> get props => [requestState, movies, errorMessage, pageTitle];
}
