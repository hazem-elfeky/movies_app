import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies/core/widgets/handling_data_request.dart';
import 'package:my_movies/features/genre/domain/usecases/get_genre_usecase.dart';
import '../../domain/entities/genre_entity.dart';

part 'genre_state.dart';
part 'genre_event.dart';

class GenreBloc extends Bloc<GenreEvent, GenreState> {
  final GetGenresUseCase getGenresUseCase;

  GenreBloc(this.getGenresUseCase) : super(GenreState.initial()) {
    on<FetchGenresEvent>(_onFetchGenres);
  }

  Future<void> _onFetchGenres(
    FetchGenresEvent event,
    Emitter<GenreState> emit,
  ) async {
    emit(state.copyWith(requestState: RequestState.loading));

    final result = await getGenresUseCase();

    result.fold(
      (failure) => emit(
        state.copyWith(
          requestState: RequestState.error,
          errorMessage: failure.message,
        ),
      ),
      (genres) {
        if (genres.isEmpty) {
          emit(state.copyWith(requestState: RequestState.empty));
        } else {
          emit(
            state.copyWith(requestState: RequestState.success, genres: genres),
          );
        }
      },
    );
  }
}
