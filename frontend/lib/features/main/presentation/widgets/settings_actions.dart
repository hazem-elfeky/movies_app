import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies/config/routes.dart';
import 'package:my_movies/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:my_movies/features/auth/presentation/bloc/auth_event.dart';
import 'settings_button.dart';

class SettingsActions extends StatelessWidget {
  final String username;
  final ColorScheme colorScheme;

  const SettingsActions({
    super.key,
    required this.username,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsButton(
          icon: Icons.favorite,
          label: 'Favorites',
          color: colorScheme.primary,
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.favorites);
          },
        ),
        SettingsButton(
          icon: Icons.logout,
          label: 'Logout',
          color: colorScheme.error,
          onPressed: () {
            context.read<AuthBloc>().add(AuthLogoutRequested());
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.login,
              (route) => false,
            );
          },
        ),
      ],
    );
  }
}
