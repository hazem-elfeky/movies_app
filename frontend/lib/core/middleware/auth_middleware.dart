import 'package:flutter/material.dart';
import 'package:my_movies/core/di/injection_container.dart';
import 'package:my_movies/core/services/app_prefs.dart';
import 'package:my_movies/screens/splash_screen.dart';
import 'package:my_movies/features/auth/presentation/pages/login_page.dart';
import 'package:my_movies/features/main/presentation/pages/main_screen.dart';

class AuthMiddleware extends StatefulWidget {
  const AuthMiddleware({Key? key}) : super(key: key);

  @override
  State<AuthMiddleware> createState() => _AuthMiddlewareState();
}

class _AuthMiddlewareState extends State<AuthMiddleware> {
  final sharedPreferencesService = getIt<SharedPreferencesService>();

  @override
  void initState() {
    super.initState();
    _navigateUser();
  }

  Future<void> _navigateUser() async {
    await Future.delayed(const Duration(seconds: 2));

    final isLoggedIn = sharedPreferencesService.isLoggedIn;

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => isLoggedIn ? const MainScreen() : const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
