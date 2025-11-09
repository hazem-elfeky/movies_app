import 'package:equatable/equatable.dart';
import 'package:my_movies/core/widgets/handling_data_request.dart';
import '../../domain/entities/movie_entity.dart';

class MovieGetDetailsState extends Equatable {
  final MovieEntity? movie;
  final RequestState requestState;
  final String? errorMessage;

  const MovieGetDetailsState({
    this.movie,
    this.requestState = RequestState.loading,
    this.errorMessage,
  });

  MovieGetDetailsState copyWith({
    MovieEntity? movie,
    RequestState? requestState,
    String? errorMessage,
  }) {
    return MovieGetDetailsState(
      movie: movie ?? this.movie,
      requestState: requestState ?? this.requestState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [movie, requestState, errorMessage];
}
