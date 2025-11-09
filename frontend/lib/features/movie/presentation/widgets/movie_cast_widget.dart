import 'package:flutter/material.dart';
import 'package:my_movies/features/actor/presentation/widgets/actor_grid_widget.dart';

class MovieCastWidget extends StatelessWidget {
  final int movieId;

  const MovieCastWidget({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Cast', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        ActorsGridWidget(movieId: movieId),
      ],
    );
  }
}
