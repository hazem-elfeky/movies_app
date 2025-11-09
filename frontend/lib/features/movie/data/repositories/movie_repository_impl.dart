import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/movie_entity.dart';
import '../../domain/repositories/movie_repository.dart';
import '../datasources/movie_remote_data_source.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remote;
  final NetworkInfo networkInfo;

  MovieRepositoryImpl(this.remote, this.networkInfo);

  @override
  Future<Either<Failure, List<MovieEntity>>> getMovies({
    String? type,
    int? genreId,
    int? page,
    String? search,
    int? actorId,
  }) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure('No internet connection'));
    }

    return await remote.getMovies(
      type: type,
      genreId: genreId,
      page: page,
      search: search,
      actorId: actorId,
    );
  }

  @override
  Future<Either<Failure, MovieEntity>> getMovieDetails(int movieId) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure('No internet connection'));
    }

    return await remote.getMovieDetails(movieId);
  }
}
