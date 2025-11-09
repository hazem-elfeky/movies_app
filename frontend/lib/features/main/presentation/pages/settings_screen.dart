import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies/core/di/injection_container.dart';
import 'package:my_movies/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:my_movies/features/main/presentation/widgets/settings_body.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: BlocProvider.value(
        value: getIt<AuthBloc>(),
        child: const SettingsBody(),
      ),
    );
  }
}
