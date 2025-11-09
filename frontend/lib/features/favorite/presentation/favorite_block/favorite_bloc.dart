import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies/core/widgets/handling_data_request.dart';
import 'favorite_event.dart';
import 'favorite_state.dart';
import '../../domain/usecases/get_favorite_movies_usecase.dart';
import '../../domain/usecases/toggle_favorite_usecase.dart';
import 'package:my_movies/config/usecases.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final GetFavoritesUseCase getFavoritesUseCase;
  final ToggleFavoriteUseCase toggleFavoriteUseCase;

  FavoriteBloc({
    required this.getFavoritesUseCase,
    required this.toggleFavoriteUseCase,
  }) : super(const FavoriteState()) {
    on<FetchFavoritesEvent>(_onFetchFavorites);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
  }

  void _onFetchFavorites(
    FetchFavoritesEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(state.copyWith(requestState: RequestState.loading));
    final result = await getFavoritesUseCase(NoParams());
    result.fold(
      (failure) => emit(
        state.copyWith(
          requestState: RequestState.error,
          errorMessage: failure.message,
        ),
      ),
      (movies) => emit(
        state.copyWith(
          favorites: movies,
          requestState: movies.isEmpty
              ? RequestState.empty
              : RequestState.success,
        ),
      ),
    );
  }

  void _onToggleFavorite(
    ToggleFavoriteEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    final result = await toggleFavoriteUseCase(event.movieId);
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message)),
      (_) => add(FetchFavoritesEvent()),
    );
  }
}
