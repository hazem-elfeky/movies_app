import 'package:my_movies/config/app_links.dart';
import 'package:my_movies/core/errors/exceptions.dart';
import 'package:my_movies/core/network/api_client.dart';
import '../models/actor_model.dart';

abstract class ActorRemoteDataSource {
  Future<List<ActorModel>> getMovieActors(int movieId);
}

class ActorRemoteDataSourceImpl implements ActorRemoteDataSource {
  final ApiClient apiClient;

  ActorRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<ActorModel>> getMovieActors(int movieId) async {
    final url = AppLinks.movieActors(movieId);

    final responseEither = await apiClient.getData(url);

    return responseEither.fold(
      (failure) => throw ServerException(failure.message),
      (jsonResponse) {
        final List<dynamic> actorJsonList =
            (jsonResponse['data'] ?? []) as List<dynamic>;

        if (actorJsonList.isEmpty) {
          return [];
        }

        return actorJsonList.map((json) => ActorModel.fromJson(json)).toList();
      },
    );
  }
}
