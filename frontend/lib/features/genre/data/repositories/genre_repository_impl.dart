import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/genre_entity.dart';
import '../../domain/repositories/genre_repository.dart';
import '../datasources/genre_remote_data_source.dart';

class GenreRepositoryImpl implements GenreRepository {
  final GenreRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  GenreRepositoryImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, List<GenreEntity>>> getGenres() async {
    if (await networkInfo.isConnected) {
      return await remoteDataSource.getGenres();
    } else {
      return Left(NetworkFailure('No Internet connection'));
    }
  }
}
