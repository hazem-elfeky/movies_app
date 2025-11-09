import '../../../genre/domain/entities/genre_entity.dart';
import '../../domain/entities/movie_entity.dart';

class MovieModel extends MovieEntity {
  const MovieModel({
    required super.id,
    required super.title,
    required super.description,
    required super.poster,
    required super.banner,
    required super.type,
    required super.releaseDate,
    required super.vote,
    required super.voteCount,
    required super.genres,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      poster: json['poster'] ?? '',
      banner: json['banner'] ?? '',
      type: json['type'] ?? '',
      releaseDate: json['release_date'] ?? '',
      vote: (json['vote'] ?? 0).toDouble(),
      voteCount: json['vote_count'] ?? 0,
      genres: (json['genres'] as List<dynamic>? ?? [])
          .map(
            (e) => GenreEntity(
              id: e['id'],
              name: e['name'],
              moviesCount: e['movies_count'],
            ),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'poster': poster,
      'banner': banner,
      'type': type,
      'release_date': releaseDate,
      'vote': vote,
      'vote_count': voteCount,
      'genres': genres
          .map(
            (genre) => {
              'id': genre.id,
              'name': genre.name,
              'movies_count': genre.moviesCount,
            },
          )
          .toList(),
    };
  }
}
