import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies/core/widgets/handling_data_request.dart';
import 'package:my_movies/features/movie/presentation/get_movie_block/movie_bloc.dart';
import 'package:my_movies/features/movie/presentation/get_movie_block/movie_event.dart';
import 'package:my_movies/features/movie/presentation/get_movie_block/movie_state.dart';
import 'package:my_movies/features/movie/presentation/widgets/movie_card.dart';
import 'package:my_movies/config/routes.dart';
import 'package:my_movies/core/navigation/app_navigator.dart';
import 'package:my_movies/core/di/injection_container.dart';

class MovieSectionWidget extends StatelessWidget {
  final String title;
  final String type;

  const MovieSectionWidget({
    super.key,
    required this.title,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final movieBloc = getIt<MovieBloc>();
    final navigator = getIt<AppNavigator>();

    movieBloc.add(FetchMoviesEvent(type: type));

    return BlocBuilder<MovieBloc, MovieState>(
      bloc: movieBloc,
      builder: (context, state) {
        return HandlingDataRequest(
          requestState: state.requestState,
          errorMessage: state.errorMessage,
          widget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        navigator.pushNamed(
                          AppRoutes.movies,
                          arguments: {'type': type},
                        );
                      },
                      child: const Text("Show All ›"),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 250,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemCount: state.movies.length,
                  itemBuilder: (context, index) {
                    final movie = state.movies[index];
                    return SizedBox(width: 150, child: MovieCard(movie: movie));
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
