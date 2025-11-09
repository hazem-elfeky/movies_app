import 'package:flutter/material.dart';
import 'package:my_movies/core/di/injection_container.dart';
import 'package:my_movies/core/services/app_prefs.dart';
import 'settings_header.dart';
import 'settings_actions.dart';

class SettingsBody extends StatelessWidget {
  const SettingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final prefs = getIt<SharedPreferencesService>();
    final username = prefs.getUsername() ?? 'User';
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          SettingsHeader(username: username),
          const SizedBox(height: 35),
          SettingsActions(username: username, colorScheme: colorScheme),
        ],
      ),
    );
  }
}
