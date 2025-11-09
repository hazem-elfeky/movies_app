import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies/core/di/injection_container.dart';
import 'package:my_movies/core/widgets/handling_data_request.dart';
import 'package:my_movies/features/favorite/presentation/favorite_block/favorite_bloc.dart';
import 'package:my_movies/features/favorite/presentation/favorite_block/favorite_event.dart';
import 'package:my_movies/features/favorite/presentation/favorite_block/favorite_state.dart';
import 'package:my_movies/features/movie/presentation/pages/movie_details_page.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<FavoriteBloc>()..add(FetchFavoritesEvent()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Favorites'), centerTitle: true),
        body: BlocBuilder<FavoriteBloc, FavoriteState>(
          builder: (context, state) {
            return HandlingDataRequest(
              requestState: state.requestState,
              errorMessage: state.errorMessage,
              widget: state.favorites.isEmpty
                  ? const Center(child: Text('No favorite movies'))
                  : ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: state.favorites.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final movie = state.favorites[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    MovieDetailsPage(movieId: movie.id),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      movie.banner.isNotEmpty
                                          ? movie.banner
                                          : 'https://via.placeholder.com/100x140',
                                      width: 100,
                                      height: 140,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          movie.title,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          movie.description,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey,
                                          ),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 10),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: IconButton(
                                            icon: Icon(
                                              movie.isFavorite
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: Colors.red,
                                            ),
                                            onPressed: () {
                                              context.read<FavoriteBloc>().add(
                                                ToggleFavoriteEvent(movie.id),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            );
          },
        ),
      ),
    );
  }
}
