import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../errors/failures.dart';
import '../services/app_prefs.dart';

class ApiClient {
  final http.Client client;
  final SharedPreferencesService prefs;

  ApiClient(this.client, this.prefs);

  Future<Map<String, String>> _getHeaders() async {
    final token = prefs.getToken();
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};

    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }

  Future<Either<Failure, Map<String, dynamic>>> postData(
    String url,
    Map<String, String> body,
  ) async {
    try {
      final headers = await _getHeaders();

      final response = await client.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        if (jsonResponse['error'] == 1) {
          return Left(
            ServerFailure(jsonResponse['message'] ?? 'Unexpected error'),
          );
        }

        return Right(jsonResponse);
      } else {
        return Left(ServerFailure('Server error: ${response.statusCode}'));
      }
    } on SocketException {
      return Left(NetworkFailure('No internet connection'));
    } on FormatException {
      return Left(ServerFailure('Invalid response format'));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> getData(String url) async {
    try {
      final headers = await _getHeaders();

      final response = await client.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        if (jsonResponse['error'] == 1) {
          return Left(
            ServerFailure(jsonResponse['message'] ?? 'Unexpected error'),
          );
        }

        return Right(jsonResponse);
      } else {
        return Left(ServerFailure('Server error: ${response.statusCode}'));
      }
    } on SocketException {
      return Left(NetworkFailure('No internet connection'));
    } on FormatException {
      return Left(ServerFailure('Invalid response format'));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }
}
