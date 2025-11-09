import 'package:equatable/equatable.dart';
import 'package:my_movies/features/genre/domain/entities/genre_entity.dart';

class MovieEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final String poster;
  final String banner;
  final String type;
  final String releaseDate;
  final double vote;
  final int voteCount;
  final List<GenreEntity> genres;
  final bool isFavorite;

  const MovieEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.poster,
    required this.banner,
    required this.type,
    required this.releaseDate,
    required this.vote,
    required this.voteCount,
    required this.genres,
    this.isFavorite = false,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    poster,
    banner,
    type,
    releaseDate,
    vote,
    voteCount,
    genres,
    isFavorite,
  ];
}
