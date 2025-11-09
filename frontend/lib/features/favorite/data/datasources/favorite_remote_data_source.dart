import 'package:my_movies/config/app_links.dart';
import 'package:my_movies/core/network/api_client.dart';
import 'package:my_movies/features/movie/domain/entities/movie_entity.dart';

abstract class FavoriteRemoteDataSource {
  Future<List<MovieEntity>> getFavorites();
  Future<bool> toggleFavorite(int movieId);
}

class FavoriteRemoteDataSourceImpl implements FavoriteRemoteDataSource {
  final ApiClient client;
  FavoriteRemoteDataSourceImpl(this.client);

  @override
  Future<List<MovieEntity>> getFavorites() async {
    final result = await client.getData(AppLinks.favorites);
    return result.fold((failure) => throw Exception(failure.message), (
      jsonData,
    ) {
      final List data = jsonData['data']['data'] ?? [];
      return data
          .map(
            (e) => MovieEntity(
              id: e['id'],
              title: e['title'],
              description: e['description'] ?? "",
              poster: e['poster'] ?? "",
              banner: e['banner'] ?? "",
              type: e['type'] ?? "",
              releaseDate: e['release_date'] ?? "",
              vote: (e['vote'] ?? 0).toDouble(),
              voteCount: e['vote_count'] ?? 0,
              genres: [],
              isFavorite: true,
            ),
          )
          .toList();
    });
  }

  @override
  Future<bool> toggleFavorite(int movieId) async {
    final result = await client.getData(AppLinks.toggleFavorite(movieId));
    return result.fold(
      (failure) => throw Exception(failure.message),
      (_) => true,
    );
  }
}
