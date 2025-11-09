import 'package:flutter/material.dart';
import 'package:my_movies/features/movie/domain/entities/movie_entity.dart';
import 'package:my_movies/features/movie/presentation/widgets/movie_card.dart';

class MoviesByActorList extends StatelessWidget {
  final List<MovieEntity> movies;
  final String actorName;

  const MoviesByActorList({
    Key? key,
    required this.movies,
    required this.actorName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Known For Movies', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        movies.isEmpty
            ? Center(
                child: Text(
                  'No movies found for $actorName.',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              )
            : SizedBox(
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    final movie = movies[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: MovieCard(movie: movie),
                    );
                  },
                ),
              ),
      ],
    );
  }
}
