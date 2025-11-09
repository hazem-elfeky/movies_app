import 'package:dartz/dartz.dart';
import 'package:my_movies/core/errors/failures.dart';
import 'package:my_movies/core/services/app_prefs.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;
  final SharedPreferencesService prefs;

  AuthRepositoryImpl({required this.remote, required this.prefs});

  @override
  Future<Either<Failure, Map<String, dynamic>>> login(
    String email,
    String password,
  ) async {
    final res = await remote.login(email, password);

    if (res['error'] == true) {
      return Left(ServerFailure(res['message'] ?? 'Invalid email or password'));
    }

    final data = res['data'];
    final token = data['token'];
    final user = UserModel.fromJson(data['user']);

    await prefs.saveUserData(
      id: user.id.toString(),
      username: user.name,
      email: user.email,
      token: token,
    );

    return Right(res);
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> register(
    String name,
    String email,
    String password,
  ) async {
    final res = await remote.register(name, email, password);

    if (res['error'] == true) {
      return Left(ServerFailure(res['message'] ?? 'Failed to register user'));
    }

    final data = res['data'];
    final token = data['token'];
    final user = UserModel.fromJson(data['user']);

    await prefs.saveUserData(
      id: user.id.toString(),
      username: user.name,
      email: user.email,
      token: token,
    );

    return Right(res);
  }

  @override
  Future<Either<Failure, UserEntity>> getUser() async {
    final user = await remote.getUser();
    if (user == null) return Left(ServerFailure('User not found'));
    return Right(user);
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await prefs.clearUserData();
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isLoggedIn() async {
    try {
      return Right(prefs.isLoggedIn);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
