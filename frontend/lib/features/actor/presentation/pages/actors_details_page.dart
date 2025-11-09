import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies/features/actor/domain/entities/actor_entity.dart';
import 'package:my_movies/features/actor/presentation/widgets/actor_details_body.dart';
import 'package:my_movies/features/movie/presentation/get_movie_block/movie_bloc.dart';
import 'package:my_movies/features/movie/presentation/get_movie_block/movie_event.dart';

class ActorDetailsPage extends StatelessWidget {
  final Actor actor;

  const ActorDetailsPage({super.key, required this.actor});

  @override
  Widget build(BuildContext context) {
    final movieBloc = context.read<MovieBloc>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      movieBloc.add(FetchMoviesEvent(actorId: actor.id));
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          actor.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ActorDetailsBody(actor: actor),
    );
  }
}
