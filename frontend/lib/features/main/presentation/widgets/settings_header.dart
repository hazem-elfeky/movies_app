import 'package:flutter/material.dart';

class SettingsHeader extends StatelessWidget {
  final String username;

  const SettingsHeader({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        CircleAvatar(
          radius: 45,
          backgroundColor: colorScheme.primaryContainer,
          child: Text(
            username[0].toUpperCase(),
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: colorScheme.onPrimaryContainer,
            ),
          ),
        ),
        const SizedBox(height: 15),
        Text(
          'Welcome, $username ',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: colorScheme.onBackground,
          ),
        ),
      ],
    );
  }
}
