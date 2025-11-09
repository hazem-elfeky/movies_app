import 'package:dartz/dartz.dart';
import 'package:my_movies/core/errors/failures.dart';
import '../repositories/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository repo;
  LogoutUseCase(this.repo);

  Future<Either<Failure, void>> call() => repo.logout();
}
