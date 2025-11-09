import '../../domain/entities/genre_entity.dart';

class GenreModel extends GenreEntity {
  const GenreModel({
    required super.id,
    required super.name,
    required super.moviesCount,
  });

  factory GenreModel.fromJson(Map<String, dynamic> json) {
    return GenreModel(
      id: json['id'],
      name: json['name'],
      moviesCount: json['movies_count'],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "movies_count": moviesCount,
  };
}
