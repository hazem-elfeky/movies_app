import 'package:dartz/dartz.dart';
import 'package:my_movies/config/app_links.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/api_client.dart';
import '../models/movie_model.dart';

abstract class MovieRemoteDataSource {
  Future<Either<Failure, List<MovieModel>>> getMovies({
    String? type,
    int? genreId,
    int? page,
    String? search,
    int? actorId,
  });
  Future<Either<Failure, MovieModel>> getMovieDetails(int movieId);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final ApiClient client;

  MovieRemoteDataSourceImpl(this.client);

  @override
  Future<Either<Failure, List<MovieModel>>> getMovies({
    String? type,
    int? genreId,
    int? page,
    String? search,
    int? actorId,
  }) async {
    try {
      final queryParams = {
        if (genreId == null && type != null) 'type': type,
        if (genreId != null) 'genre_id': genreId.toString(),
        if (page != null) 'page': page.toString(),
        if (search != null) 'search': search,
      };

      final url = Uri.parse(
        AppLinks.movies,
      ).replace(queryParameters: queryParams).toString();

      final response = await client.getData(url);

      return response.fold(
        (failure) {
          return Left(failure);
        },
        (json) {
          final mainData = json['data'];
          if (mainData == null) {
            return Left(ServerFailure("Missing 'data' in response"));
          }

          final innerData = mainData['data'];
          if (innerData == null || innerData is! List) {
            return Right([]);
          }

          final movies = innerData
              .map<MovieModel>((e) => MovieModel.fromJson(e))
              .toList();

          return Right(movies);
        },
      );
    } catch (e, stack) {
      return Left(ServerFailure("MovieRemoteDataSource error: $e"));
    }
  }

  Future<Either<Failure, MovieModel>> getMovieDetails(int movieId) async {
    try {
      final url = AppLinks.movieDetails(movieId);
      final response = await client.getData(url);

      return response.fold((failure) => Left(failure), (json) {
        final outerData = json['data'];
        if (outerData == null) {
          return Left(ServerFailure("Missing 'data' in response"));
        }

        final innerData = outerData['data'];
        if (innerData == null || innerData is! Map<String, dynamic>) {
          return Left(
            ServerFailure("Unexpected data format for movie details"),
          );
        }

        final movie = MovieModel.fromJson(innerData);
        return Right(movie);
      });
    } catch (e, stack) {
      return Left(
        ServerFailure("GetMovieDetails remote data source error: $e\n$stack"),
      );
    }
  }
}
