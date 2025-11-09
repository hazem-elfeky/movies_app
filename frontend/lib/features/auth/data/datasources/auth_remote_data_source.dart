import 'package:my_movies/core/network/api_client.dart';
import '../models/user_model.dart';
import 'package:my_movies/config/app_links.dart';

abstract class AuthRemoteDataSource {
  Future<Map<String, dynamic>> login(String email, String password);
  Future<Map<String, dynamic>> register(
    String name,
    String email,
    String password,
  );
  Future<UserModel?> getUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;
  AuthRemoteDataSourceImpl(this.apiClient);

  @override
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final res = await apiClient.postData(AppLinks.login, {
        'email': email,
        'password': password,
      });

      return res.fold(
        (failure) => {
          'error': true,
          'message': failure.message ?? 'Login failed',
          'data': null,
        },
        (data) {
          if (data['data'] == null ||
              data['data']['user'] == null ||
              data['data']['token'] == null) {
            return {
              'error': true,
              'message': data['message'] ?? 'Invalid email or password',
              'data': null,
            };
          }
          return {
            'error': false,
            'message': data['message'] ?? 'Login successful',
            'data': data['data'],
          };
        },
      );
    } catch (e) {
      return {'error': true, 'message': e.toString(), 'data': null};
    }
  }

  @override
  Future<Map<String, dynamic>> register(
    String name,
    String email,
    String password,
  ) async {
    try {
      final res = await apiClient.postData(AppLinks.register, {
        'name': name,
        'email': email,
        'password': password,
      });

      return res.fold(
        (failure) => {
          'error': true,
          'message': failure.message ?? 'Registration failed',
          'data': null,
        },
        (data) {
          if (data['data'] == null ||
              data['data']['user'] == null ||
              data['data']['token'] == null) {
            return {
              'error': true,
              'message': data['message'] ?? 'Failed to register user',
              'data': null,
            };
          }
          return {
            'error': false,
            'message': data['message'] ?? 'Registration successful',
            'data': data['data'],
          };
        },
      );
    } catch (e) {
      return {'error': true, 'message': e.toString(), 'data': null};
    }
  }

  @override
  Future<UserModel?> getUser() async {
    try {
      final res = await apiClient.getData(AppLinks.user);
      final data = res.fold((f) => null, (r) => r);

      if (data == null || data['data']?['user'] == null) return null;
      return UserModel.fromJson(data['data']['user']);
    } catch (_) {
      return null;
    }
  }
}
