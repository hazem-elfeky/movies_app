import 'package:flutter/material.dart';
import 'package:my_movies/features/actor/domain/entities/actor_entity.dart';

class ActorHeader extends StatelessWidget {
  final Actor actor;

  const ActorHeader({super.key, required this.actor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: actor.image.isNotEmpty
                ? Image.network(
                    actor.image,
                    width: double.infinity,
                    height: 400,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.person, size: 120),
                  )
                : const Icon(Icons.person, size: 120),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          actor.name,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        if (actor.character.isNotEmpty)
          Text(
            "Character: ${actor.character}",
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        const SizedBox(height: 16),
        Text(
          "Popularity: ${actor.popularity}",
          style: const TextStyle(fontSize: 16),
        ),
        if (actor.knownForDepartment.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text(
            "Known For: ${actor.knownForDepartment}",
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ],
    );
  }
}
