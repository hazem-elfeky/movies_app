import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_movies/config/app_colors.dart';
import 'package:my_movies/features/movie/domain/entities/movie_entity.dart';

class MovieInfoWidget extends StatelessWidget {
  final MovieEntity movie;

  const MovieInfoWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: movie.poster,
              height: 200,
              fit: BoxFit.cover,
              placeholder: (_, __) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (_, __, ___) =>
                  const Icon(Icons.error, color: AppColors.errorColor),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Release Date: ${DateFormat('dd MMM yyyy').format(DateTime.parse(movie.releaseDate))}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: AppColors.primaryColor,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${movie.vote.toStringAsFixed(1)} (${movie.voteCount} votes)',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Type: ${movie.type}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: movie.genres
                    .map(
                      (genre) => Chip(
                        label: Text(genre.name),
                        backgroundColor: AppColors.surfaceColor,
                        labelStyle: Theme.of(context).textTheme.bodySmall
                            ?.copyWith(color: AppColors.onSurfaceColor),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
