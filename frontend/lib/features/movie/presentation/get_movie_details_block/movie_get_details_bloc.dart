import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies/core/widgets/handling_data_request.dart';
import '../../domain/usecases/get_movie_details_usecase.dart';
import 'movie_get_details_event.dart';
import 'movie_get_details_state.dart';

class MovieGetDetailsBloc
    extends Bloc<MovieGetDetailsEvent, MovieGetDetailsState> {
  final GetMovieDetailsUseCase getMovieDetailsUseCase;

  MovieGetDetailsBloc(this.getMovieDetailsUseCase)
    : super(const MovieGetDetailsState()) {
    on<FetchMovieDetailsEvent>(_onFetchMovieDetails);
  }

  void _onFetchMovieDetails(
    FetchMovieDetailsEvent event,
    Emitter<MovieGetDetailsState> emit,
  ) async {
    emit(state.copyWith(requestState: RequestState.loading));
    final result = await getMovieDetailsUseCase(event.movieId);

    result.fold(
      (failure) => emit(
        state.copyWith(
          requestState: RequestState.error,
          errorMessage: failure.message,
        ),
      ),
      (movie) => emit(
        state.copyWith(
          movie: movie,
          requestState: movie != null
              ? RequestState.success
              : RequestState.empty,
        ),
      ),
    );
  }
}
