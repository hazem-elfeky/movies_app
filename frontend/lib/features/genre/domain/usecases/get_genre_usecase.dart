import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/genre_entity.dart';
import '../repositories/genre_repository.dart';

class GetGenresUseCase {
  final GenreRepository repository;

  GetGenresUseCase(this.repository);

  Future<Either<Failure, List<GenreEntity>>> call() {
    return repository.getGenres();
  }
}
