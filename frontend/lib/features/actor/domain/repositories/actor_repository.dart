import 'package:dartz/dartz.dart';
import 'package:my_movies/core/errors/failures.dart';
import 'package:my_movies/features/actor/domain/entities/actor_entity.dart';

abstract class ActorRepository {
  Future<Either<Failure, List<Actor>>> getMovieActors(int movieId);
}
