import 'package:dartz/dartz.dart';
import 'package:my_movies/core/errors/failures.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repo;
  LoginUseCase(this.repo);

  Future<Either<Failure, Map<String, dynamic>>> call(
    String email,
    String password,
  ) {
    return repo.login(email, password);
  }
}
