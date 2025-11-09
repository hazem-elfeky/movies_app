import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/handling_data_request.dart';
import '../../domain/usecases/get_movies_usecase.dart';
import 'movie_event.dart';
import 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetMoviesUseCase getMoviesUseCase;

  MovieBloc(this.getMoviesUseCase) : super(const MovieState()) {
    on<FetchMoviesEvent>(_onFetchMovies);
    on<SearchMoviesEvent>(_onSearchMovies);
  }

  Future<void> _onFetchMovies(
    FetchMoviesEvent event,
    Emitter<MovieState> emit,
  ) async {
    emit(state.copyWith(requestState: RequestState.loading));

    final result = await getMoviesUseCase(
      type: event.type,
      genreId: event.genreId,
      page: event.page,
      search: event.search,
      actorId: event.actorId,
    );

    final pageTitle = _getPageTitle(event);

    result.fold(
      (failure) => emit(
        state.copyWith(
          requestState: RequestState.error,
          errorMessage: failure.message,
          pageTitle: pageTitle,
        ),
      ),
      (movies) {
        if (movies.isEmpty) {
          emit(
            state.copyWith(
              requestState: RequestState.empty,
              pageTitle: pageTitle,
            ),
          );
        } else {
          emit(
            state.copyWith(
              requestState: RequestState.success,
              movies: movies,
              pageTitle: pageTitle,
            ),
          );
        }
      },
    );
  }

  Future<void> _onSearchMovies(
    SearchMoviesEvent event,
    Emitter<MovieState> emit,
  ) async {
    final query = event.query.trim();

    if (query.isEmpty) {
      emit(state.copyWith(requestState: RequestState.empty, movies: []));
      return;
    }

    emit(state.copyWith(requestState: RequestState.loading));

    final result = await getMoviesUseCase(search: query);

    result.fold(
      (failure) => emit(
        state.copyWith(
          requestState: RequestState.error,
          errorMessage: failure.message,
        ),
      ),
      (movies) {
        if (movies.isEmpty) {
          emit(state.copyWith(requestState: RequestState.empty, movies: []));
        } else {
          emit(
            state.copyWith(requestState: RequestState.success, movies: movies),
          );
        }
      },
    );
  }

  String _getPageTitle(FetchMoviesEvent event) {
    if (event.genreName != null && event.genreName!.isNotEmpty) {
      return event.genreName!;
    }

    switch (event.type) {
      case 'popular':
        return "Popular Movies";
      case 'now_playing':
        return "Now Playing";
      case 'top_rated':
        return "Top Rated";
      case 'upcoming':
        return "Upcoming Movies";
      default:
        return "Movies";
    }
  }
}
