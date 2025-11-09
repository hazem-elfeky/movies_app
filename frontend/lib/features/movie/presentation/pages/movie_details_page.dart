import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies/core/di/injection_container.dart';
import 'package:my_movies/core/widgets/handling_data_request.dart';
import 'package:my_movies/features/movie/presentation/get_movie_details_block/movie_get_details_bloc.dart';
import 'package:my_movies/features/movie/presentation/get_movie_details_block/movie_get_details_event.dart';
import 'package:my_movies/features/movie/presentation/get_movie_details_block/movie_get_details_state.dart';
import 'package:my_movies/features/movie/presentation/widgets/movie_cast_widget.dart';
import 'package:my_movies/features/movie/presentation/widgets/movie_description_widget.dart';
import 'package:my_movies/features/movie/presentation/widgets/movie_header_widget.dart';
import 'package:my_movies/features/movie/presentation/widgets/movie_info_widget.dart';
import 'package:my_movies/features/favorite/presentation/favorite_block/favorite_bloc.dart';
import 'package:my_movies/features/favorite/presentation/favorite_block/favorite_event.dart';
import 'package:my_movies/features/favorite/domain/usecases/get_favorite_movies_usecase.dart';
import 'package:my_movies/features/favorite/domain/usecases/toggle_favorite_usecase.dart';

class MovieDetailsPage extends StatelessWidget {
  final int movieId;
  const MovieDetailsPage({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              getIt<MovieGetDetailsBloc>()
                ..add(FetchMovieDetailsEvent(movieId)),
        ),
        BlocProvider(
          create: (_) => FavoriteBloc(
            getFavoritesUseCase: getIt<GetFavoritesUseCase>(),
            toggleFavoriteUseCase: getIt<ToggleFavoriteUseCase>(),
          )..add(FetchFavoritesEvent()),
        ),
      ],
      child: Scaffold(
        body: BlocBuilder<MovieGetDetailsBloc, MovieGetDetailsState>(
          builder: (context, state) {
            return HandlingDataRequest(
              requestState: state.requestState,
              errorMessage: state.errorMessage,
              widget: state.movie == null
                  ? const Center(child: Text("Film details not found."))
                  : CustomScrollView(
                      slivers: [
                        MovieHeaderWidget(movie: state.movie!),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MovieInfoWidget(movie: state.movie!),
                                const SizedBox(height: 24),
                                MovieDescriptionWidget(movie: state.movie!),
                                const SizedBox(height: 32),
                                MovieCastWidget(movieId: movieId),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }
}
