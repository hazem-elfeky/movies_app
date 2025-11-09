import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/movie_entity.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<MovieEntity>>> getMovies({
    String? type,
    int? genreId,
    int? page,
    String? search,
    int? actorId,
  });

  Future<Either<Failure, MovieEntity>> getMovieDetails(int movieId);
}
