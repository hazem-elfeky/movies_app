import 'package:dartz/dartz.dart';
import 'package:my_movies/core/errors/failures.dart';
import '../repositories/auth_repository.dart';
import '../entities/user_entity.dart';

class GetUserUseCase {
  final AuthRepository repo;
  GetUserUseCase(this.repo);

  Future<Either<Failure, UserEntity>> call() => repo.getUser();
}
