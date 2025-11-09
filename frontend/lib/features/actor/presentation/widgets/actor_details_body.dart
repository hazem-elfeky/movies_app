import 'package:flutter/material.dart';
import 'package:my_movies/features/actor/domain/entities/actor_entity.dart';
import 'package:my_movies/features/actor/presentation/widgets/actor_details_header.dart';
import 'actor_movies_grid.dart';

class ActorDetailsBody extends StatelessWidget {
  final Actor actor;

  const ActorDetailsBody({super.key, required this.actor});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ActorHeader(actor: actor),
          const SizedBox(height: 32),
          const Divider(thickness: 1),
          const Text(
            "Movies by this Actor",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const ActorMoviesGrid(),
        ],
      ),
    );
  }
}
