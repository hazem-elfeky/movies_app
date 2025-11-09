import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies/features/favorite/presentation/favorite_block/favorite_bloc.dart';
import 'package:my_movies/features/favorite/presentation/favorite_block/favorite_event.dart';
import 'package:my_movies/features/favorite/presentation/favorite_block/favorite_state.dart';
import '../../domain/entities/movie_entity.dart';

class MovieHeaderWidget extends StatelessWidget {
  final MovieEntity movie;
  const MovieHeaderWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                movie.title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            BlocBuilder<FavoriteBloc, FavoriteState>(
              builder: (context, state) {
                final isFav = state.favorites.any(
                  (m) => m.id == movie.id && m.isFavorite,
                );

                return IconButton(
                  icon: Icon(
                    isFav ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    context.read<FavoriteBloc>().add(
                      ToggleFavoriteEvent(movie.id),
                    );
                  },
                );
              },
            ),
          ],
        ),
        background: Image.network(movie.banner, fit: BoxFit.cover),
      ),
    );
  }
}
