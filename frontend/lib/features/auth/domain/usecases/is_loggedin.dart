import 'package:dartz/dartz.dart';
import 'package:my_movies/core/errors/failures.dart';
import '../repositories/auth_repository.dart';

class IsLoggedInUseCase {
  final AuthRepository repo;
  IsLoggedInUseCase(this.repo);

  Future<Either<Failure, bool>> call() => repo.isLoggedIn();
}
