import 'package:flutter/material.dart';
import 'package:my_movies/config/routes.dart';
import 'package:my_movies/core/di/injection_container.dart';
import 'package:my_movies/core/navigation/app_navigator.dart';
import '../../domain/entities/movie_entity.dart';

class MovieCard extends StatelessWidget {
  final MovieEntity movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        getIt<AppNavigator>().pushNamed(
          AppRoutes.movieDetails,
          arguments: {'movieId': movie.id},
        );
      },

      child: Card(
        color: Colors.black26,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.network(
                movie.poster,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                movie.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
