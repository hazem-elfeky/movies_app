import 'package:flutter/material.dart';
import 'package:my_movies/config/routes.dart';
import 'package:my_movies/features/movie/domain/entities/movie_entity.dart';

class MovieListWidget extends StatelessWidget {
  final List<MovieEntity> movies;

  const MovieListWidget({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: movies.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        final movie = movies[index];
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 12,
          ),
          leading: movie.poster.isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    movie.poster,
                    width: 60,
                    height: 90,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.broken_image),
                  ),
                )
              : const Icon(Icons.image, size: 60),
          title: Text(
            movie.title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          subtitle: Text(
            movie.description.isNotEmpty
                ? movie.description
                : 'No description available',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 13),
          ),
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.movieDetails,
              arguments: {'movieId': movie.id},
            );
          },
        );
      },
    );
  }
}
