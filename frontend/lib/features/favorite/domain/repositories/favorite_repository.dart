import 'package:dartz/dartz.dart';
import 'package:my_movies/core/errors/failures.dart';
import 'package:my_movies/features/movie/domain/entities/movie_entity.dart';

abstract class FavoriteRepository {
  Future<Either<Failure, List<MovieEntity>>> getFavorites();
  Future<Either<Failure, bool>> toggleFavorite(int movieId);
}
