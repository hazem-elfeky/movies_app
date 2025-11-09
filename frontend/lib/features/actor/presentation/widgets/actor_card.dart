import 'package:flutter/material.dart';
import 'package:my_movies/core/navigation/app_navigator.dart';
import 'package:my_movies/config/routes.dart';
import 'package:my_movies/core/di/injection_container.dart';
import 'package:my_movies/features/actor/domain/entities/actor_entity.dart';

class ActorCard extends StatelessWidget {
  final Actor actor;

  const ActorCard({Key? key, required this.actor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppNavigator appNavigator = getIt<AppNavigator>();

    return GestureDetector(
      onTap: () {
        appNavigator.pushNamed(
          AppRoutes.actorDetails,
          arguments: {'actorId': actor.id, 'actorName': actor.name},
        );
      },
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        color: Theme.of(context).colorScheme.surface,
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: actor.image != null && actor.image!.isNotEmpty
                    ? Image.network(
                        actor.image!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset(
                              'assets/images/placeholder.png',
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                      )
                    : Image.asset(
                        'assets/images/placeholder.png',
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                actor.name,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
