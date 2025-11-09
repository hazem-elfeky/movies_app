import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/genre_entity.dart';

abstract class GenreRepository {
  Future<Either<Failure, List<GenreEntity>>> getGenres();
}
