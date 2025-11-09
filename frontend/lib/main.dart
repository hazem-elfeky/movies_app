import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies/core/di/injection_container.dart';
import 'package:my_movies/core/navigation/app_navigator.dart';
import 'package:my_movies/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:my_movies/features/movie/presentation/get_movie_block/movie_bloc.dart';
import 'config/routes.dart';
import 'config/theme.dart';
import 'core/middleware/auth_middleware.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencyInjection();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<AuthBloc>()),
        BlocProvider(create: (_) => getIt<MovieBloc>()),
      ],
      child: MaterialApp(
        navigatorKey: AppNavigator.navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Movies App',
        theme: appTheme,
        themeMode: ThemeMode.dark,
        locale: const Locale('en'),
        initialRoute: AppRoutes.splash,
        onGenerateRoute: AppRoutes.generateRoute,
        home: const AuthMiddleware(),
      ),
    );
  }
}
