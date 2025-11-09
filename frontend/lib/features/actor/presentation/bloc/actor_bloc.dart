import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies/core/errors/failures.dart';
import 'package:my_movies/core/widgets/handling_data_request.dart';
import 'package:my_movies/features/actor/domain/usecases/get_movie_actor_usecase.dart';
import 'actor_event.dart';
import 'actor_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String NETWORK_FAILURE_MESSAGE = 'No Internet Connection';

class ActorBloc extends Bloc<ActorEvent, ActorState> {
  final GetMovieActorsUseCase getMovieActorsUseCase;

  ActorBloc({required this.getMovieActorsUseCase}) : super(const ActorState()) {
    on<GetMovieActorsEvent>(_onGetMovieActorsEvent);
  }

  Future<void> _onGetMovieActorsEvent(
    GetMovieActorsEvent event,
    Emitter<ActorState> emit,
  ) async {
    emit(state.copyWith(requestState: RequestState.loading));

    final result = await getMovieActorsUseCase(
      GetMovieActorsParams(movieId: event.movieId),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          requestState: RequestState.error,
          errorMessage: _mapFailureToMessage(failure),
        ),
      ),
      (actors) {
        if (actors.isEmpty) {
          emit(state.copyWith(requestState: RequestState.empty));
        } else {
          emit(
            state.copyWith(requestState: RequestState.success, actors: actors),
          );
        }
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      case NetworkFailure:
        return NETWORK_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
