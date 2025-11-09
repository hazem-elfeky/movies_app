import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/handling_data_request.dart';
import '../get_movie_block/movie_bloc.dart';
import '../get_movie_block/movie_event.dart';
import '../get_movie_block/movie_state.dart';
import '../widgets/movie_card.dart';

class MoviesPage extends StatelessWidget {
  final String? type;
  final int? genreId;
  final String? genreName;

  const MoviesPage({super.key, this.type, this.genreId, this.genreName});

  @override
  Widget build(BuildContext context) {
    final movieBloc = context.read<MovieBloc>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      movieBloc.add(
        FetchMoviesEvent(type: type, genreId: genreId, genreName: genreName),
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<MovieBloc, MovieState>(
          buildWhen: (previous, current) =>
              previous.pageTitle != current.pageTitle,
          builder: (context, state) => Text(
            state.pageTitle,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          return HandlingDataRequest(
            requestState: state.requestState,
            errorMessage: state.errorMessage,
            widget: GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: state.movies.length,
              itemBuilder: (context, index) {
                final movie = state.movies[index];
                return MovieCard(movie: movie);
              },
            ),
          );
        },
      ),
    );
  }
}
