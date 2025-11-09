// lib/features/actor/data/repositories/actor_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:my_movies/core/errors/exceptions.dart';
import 'package:my_movies/core/errors/failures.dart';
import 'package:my_movies/core/network/network_info.dart';
import 'package:my_movies/features/actor/domain/entities/actor_entity.dart';
import 'package:my_movies/features/actor/domain/repositories/actor_repository.dart';
import '../datasources/actor_remote_data_source.dart';

class ActorRepositoryImpl implements ActorRepository {
  final ActorRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ActorRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Actor>>> getMovieActors(int movieId) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteActors = await remoteDataSource.getMovieActors(movieId);
        return Right(remoteActors);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(NetworkFailure('Please check your internet connection.'));
    }
  }
}
