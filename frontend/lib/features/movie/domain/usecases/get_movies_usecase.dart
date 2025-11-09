import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/movie_entity.dart';
import '../repositories/movie_repository.dart';

class GetMoviesUseCase {
  final MovieRepository repository;

  GetMoviesUseCase(this.repository);

  Future<Either<Failure, List<MovieEntity>>> call({
    String? type,
    int? genreId,
    int? page,
    String? search,
    int? actorId,
  }) {
    return repository.getMovies(
      type: type,
      genreId: genreId,
      page: page,
      search: search,
      actorId: actorId,
    );
  }
}
