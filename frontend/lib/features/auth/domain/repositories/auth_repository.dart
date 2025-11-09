import 'package:dartz/dartz.dart';
import 'package:my_movies/core/errors/failures.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, Map<String, dynamic>>> login(
    String email,
    String password,
  );
  Future<Either<Failure, Map<String, dynamic>>> register(
    String name,
    String email,
    String password,
  );
  Future<Either<Failure, UserEntity>> getUser();
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, bool>> isLoggedIn();
}
