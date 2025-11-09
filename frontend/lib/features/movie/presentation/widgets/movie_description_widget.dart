import 'package:flutter/material.dart';
import 'package:my_movies/features/movie/domain/entities/movie_entity.dart';

class MovieDescriptionWidget extends StatelessWidget {
  final MovieEntity movie;

  const MovieDescriptionWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Description', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        Text(movie.description, style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}
