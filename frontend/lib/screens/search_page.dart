import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies/core/widgets/handling_data_request.dart';
import 'package:my_movies/core/widgets/movie_list_widget_search.dart';
import 'package:my_movies/core/widgets/search_field_widget.dart';
import 'package:my_movies/features/movie/presentation/get_movie_block/movie_bloc.dart';
import 'package:my_movies/features/movie/presentation/get_movie_block/movie_event.dart';
import 'package:my_movies/features/movie/presentation/get_movie_block/movie_state.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: const Text(
          ' Search Movies',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SearchFieldWidget(
              onSearchChanged: (query) {
                context.read<MovieBloc>().add(SearchMoviesEvent(query));
              },
            ),

            const SizedBox(height: 16),

            Expanded(
              child: BlocBuilder<MovieBloc, MovieState>(
                builder: (context, state) {
                  return HandlingDataRequest(
                    requestState: state.requestState,
                    errorMessage: state.errorMessage,
                    widget: MovieListWidget(movies: state.movies),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
