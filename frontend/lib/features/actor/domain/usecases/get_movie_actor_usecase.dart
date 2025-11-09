import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:my_movies/config/usecases.dart';
import 'package:my_movies/core/errors/failures.dart';
import 'package:my_movies/features/actor/domain/entities/actor_entity.dart';
import '../repositories/actor_repository.dart';

class GetMovieActorsUseCase
    implements UseCase<List<Actor>, GetMovieActorsParams> {
  final ActorRepository repository;

  GetMovieActorsUseCase(this.repository);

  @override
  Future<Either<Failure, List<Actor>>> call(GetMovieActorsParams params) async {
    return await repository.getMovieActors(params.movieId);
  }
}

class GetMovieActorsParams extends Equatable {
  final int movieId;

  const GetMovieActorsParams({required this.movieId});

  @override
  List<Object> get props => [movieId];
}
