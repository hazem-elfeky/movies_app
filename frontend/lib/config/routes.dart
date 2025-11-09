import 'package:flutter/material.dart';
import 'package:my_movies/features/actor/domain/entities/actor_entity.dart';
import 'package:my_movies/features/actor/presentation/pages/actors_details_page.dart';
import 'package:my_movies/features/auth/presentation/pages/login_page.dart';
import 'package:my_movies/features/auth/presentation/pages/signup_page.dart';
import 'package:my_movies/features/favorite/presentation/pages/favorite_screen.dart';
import 'package:my_movies/features/movie/presentation/pages/movies_list_page.dart';
import 'package:my_movies/features/main/presentation/pages/main_screen.dart';
import 'package:my_movies/features/movie/presentation/pages/movie_details_page.dart';
import 'package:my_movies/screens/splash_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String main = '/main';
  static const String favorites = '/favorites';
  static const String movies = '/movies';
  static const String actorDetails = '/actorDetails';
  static const String movieDetails = '/movieDetails';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case main:
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case favorites:
        return MaterialPageRoute(builder: (_) => const FavoritesPage());
      case movies:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) =>
              MoviesPage(genreId: args?['genreId'], type: args?['type']),
        );
      case actorDetails:
        final args = settings.arguments as Map<String, dynamic>?;
        final Actor? actor = args?['actor'] as Actor?;
        if (actor == null) {
          return MaterialPageRoute(
            builder: (_) => const Scaffold(
              body: Center(
                child: Text(
                  'No actor data provided',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          );
        }
        return MaterialPageRoute(
          builder: (_) => ActorDetailsPage(actor: actor),
        );
      case movieDetails:
        final args = settings.arguments as Map<String, dynamic>;
        final movieId = args['movieId'] as int;
        return MaterialPageRoute(
          builder: (_) => MovieDetailsPage(movieId: movieId),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
