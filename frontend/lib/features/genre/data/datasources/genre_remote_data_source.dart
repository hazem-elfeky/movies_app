import 'package:dartz/dartz.dart';
import 'package:my_movies/config/app_links.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/api_client.dart';
import '../models/genre_model.dart';

abstract class GenreRemoteDataSource {
  Future<Either<Failure, List<GenreModel>>> getGenres();
}

class GenreRemoteDataSourceImpl implements GenreRemoteDataSource {
  final ApiClient apiClient;

  GenreRemoteDataSourceImpl(this.apiClient);

  @override
  Future<Either<Failure, List<GenreModel>>> getGenres() async {
    final response = await apiClient.getData(AppLinks.genres);

    return response.fold((failure) => Left(failure), (data) {
      final List<dynamic> list = data['data'];
      final genres = list.map((json) => GenreModel.fromJson(json)).toList();
      return Right(genres);
    });
  }
}
