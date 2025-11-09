import 'package:dartz/dartz.dart';
import 'package:my_movies/core/errors/failures.dart';
import 'package:my_movies/core/network/network_info.dart';
import 'package:my_movies/features/favorite/data/datasources/favorite_remote_data_source.dart';
import 'package:my_movies/features/movie/domain/entities/movie_entity.dart';
import '../../domain/repositories/favorite_repository.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteRemoteDataSource remote;
  final NetworkInfo networkInfo;

  FavoriteRepositoryImpl({required this.remote, required this.networkInfo});

  @override
  Future<Either<Failure, List<MovieEntity>>> getFavorites() async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure('No internet connection'));
    }
    try {
      final movies = await remote.getFavorites();
      return Right(movies);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> toggleFavorite(int movieId) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure('No internet connection'));
    }
    try {
      final result = await remote.toggleFavorite(movieId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
