// lib/features/actor/presentation/widgets/actor_grid_widget.dart
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies/core/widgets/handling_data_request.dart';
import 'package:my_movies/core/di/injection_container.dart';
import 'package:my_movies/core/navigation/app_navigator.dart';
import 'package:my_movies/config/routes.dart';
import 'package:my_movies/features/actor/presentation/bloc/actor_bloc.dart';
import 'package:my_movies/features/actor/presentation/bloc/actor_state.dart';
import 'package:my_movies/features/actor/domain/entities/actor_entity.dart';
import 'package:my_movies/features/actor/presentation/bloc/actor_event.dart';

class ActorsGridWidget extends StatelessWidget {
  final int movieId;

  const ActorsGridWidget({Key? key, required this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<ActorBloc>()..add(GetMovieActorsEvent(movieId: movieId)),
      child: BlocBuilder<ActorBloc, ActorState>(
        builder: (context, state) {
          return HandlingDataRequest(
            requestState: state.requestState,
            errorMessage: state.errorMessage,
            widget: _buildGrid(context, state.actors ?? []),
          );
        },
      ),
    );
  }

  Widget _buildGrid(BuildContext context, List<Actor> actors) {
    if (actors.isEmpty) return const SizedBox.shrink();

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.6,
      ),
      itemCount: actors.length,
      itemBuilder: (context, index) {
        final actor = actors[index];
        return GestureDetector(
          onTap: () {
            final navigator = getIt<AppNavigator>();
            navigator.pushNamed(
              AppRoutes.actorDetails,
              arguments: {'actor': actor},
            );
          },
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: actor.image.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: actor.image,
                        height: 120,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.person, size: 50),
                      )
                    : const Icon(Icons.person, size: 50),
              ),
              const SizedBox(height: 8),
              Text(
                actor.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        );
      },
    );
  }
}
