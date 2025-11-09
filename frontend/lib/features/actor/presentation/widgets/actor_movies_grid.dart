import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies/core/widgets/handling_data_request.dart';
import 'package:my_movies/features/movie/presentation/get_movie_block/movie_bloc.dart';
import 'package:my_movies/features/movie/presentation/get_movie_block/movie_state.dart';
import 'package:my_movies/features/movie/presentation/widgets/movie_card.dart';

class ActorMoviesGrid extends StatelessWidget {
  const ActorMoviesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        return HandlingDataRequest(
          requestState: state.requestState,
          errorMessage: state.errorMessage,
          widget: state.movies.isEmpty
              ? const Center(child: Text("No movies found for this actor."))
              : GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
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
    );
  }
}
