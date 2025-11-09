import 'package:equatable/equatable.dart';

abstract class ActorEvent extends Equatable {
  const ActorEvent();

  @override
  List<Object> get props => [];
}

class GetMovieActorsEvent extends ActorEvent {
  final int movieId;
  const GetMovieActorsEvent({required this.movieId});

  @override
  List<Object> get props => [movieId];
}
