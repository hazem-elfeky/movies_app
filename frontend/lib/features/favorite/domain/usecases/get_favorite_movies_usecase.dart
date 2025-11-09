import 'package:dartz/dartz.dart';
import 'package:my_movies/config/usecases.dart';
import 'package:my_movies/core/errors/failures.dart';
import 'package:my_movies/features/movie/domain/entities/movie_entity.dart';
import '../repositories/favorite_repository.dart';

class GetFavoritesUseCase implements UseCase<List<MovieEntity>, NoParams> {
  final FavoriteRepository repository;
  GetFavoritesUseCase(this.repository);

  @override
  Future<Either<Failure, List<MovieEntity>>> call(NoParams params) async {
    return repository.getFavorites();
  }
}
