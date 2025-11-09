import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies/core/di/injection_container.dart';
import 'package:my_movies/core/widgets/handling_data_request.dart';
import 'package:my_movies/features/movie/presentation/pages/movies_list_page.dart';
import '../bloc/genre_bloc.dart';
import '../widgets/genre_card.dart';

class GenresPage extends StatelessWidget {
  const GenresPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<GenreBloc>()..add(FetchGenresEvent()),
      child: Scaffold(
        appBar: AppBar(title: const Text("Genres")),
        body: BlocBuilder<GenreBloc, GenreState>(
          builder: (context, state) {
            return HandlingDataRequest(
              requestState: state.requestState,
              errorMessage: state.errorMessage,
              widget: GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.2,
                ),
                itemCount: state.genres.length,
                itemBuilder: (context, index) {
                  final genre = state.genres[index];
                  return GenreCard(
                    genre: genre,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MoviesPage(
                            genreId: genre.id,
                            genreName: genre.name,
                          ),
                        ),
                      );
                    },
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
