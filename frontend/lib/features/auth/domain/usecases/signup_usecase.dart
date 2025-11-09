import 'package:dartz/dartz.dart';
import 'package:my_movies/core/errors/failures.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repo;
  RegisterUseCase(this.repo);

  Future<Either<Failure, Map<String, dynamic>>> call(
    String name,
    String email,
    String password,
  ) {
    return repo.register(name, email, password);
  }
}
