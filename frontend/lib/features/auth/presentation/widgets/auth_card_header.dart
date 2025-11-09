import 'package:flutter/material.dart';
import 'package:my_movies/config/app_colors.dart';

class AuthCardHeader extends StatelessWidget {
  final String title;
  const AuthCardHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.surfaceColor,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 24),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 36),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [AppColors.primaryColor, Color(0xFFFFE082)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Text(
            title.toUpperCase(),
            style: const TextStyle(
              color: AppColors.onPrimaryColor,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
