import 'package:equatable/equatable.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object?> get props => [];
}

class FetchMoviesEvent extends MovieEvent {
  final String? type;
  final int? genreId;
  final String? genreName;
  final int? page;
  final String? search;
  final int? actorId;

  const FetchMoviesEvent({
    this.type,
    this.genreId,
    this.genreName,
    this.page,
    this.search,
    this.actorId,
  });

  @override
  List<Object?> get props => [type, genreId, genreName, page, search, actorId];
}

class SearchMoviesEvent extends MovieEvent {
  final String query;

  const SearchMoviesEvent(this.query);

  @override
  List<Object?> get props => [query];
}
