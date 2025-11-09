import 'package:equatable/equatable.dart';
import 'package:my_movies/core/widgets/handling_data_request.dart';
import 'package:my_movies/features/actor/domain/entities/actor_entity.dart';

class ActorState extends Equatable {
  final RequestState requestState;
  final List<Actor>? actors;
  final Actor? actor;
  final String? errorMessage;

  const ActorState({
    this.requestState = RequestState.loading,
    this.actors,
    this.actor,
    this.errorMessage,
  });

  ActorState copyWith({
    RequestState? requestState,
    List<Actor>? actors,
    Actor? actorDetails,
    String? errorMessage,
  }) {
    return ActorState(
      requestState: requestState ?? this.requestState,
      actors: actors ?? this.actors,
      actor: actor ?? this.actor,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [requestState, actors, actor, errorMessage];
}
