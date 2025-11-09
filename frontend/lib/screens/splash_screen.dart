import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies/config/routes.dart';
import 'package:my_movies/core/navigation/app_navigator.dart';
import 'package:my_movies/core/widgets/handling_data_request.dart';
import 'package:my_movies/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:my_movies/features/auth/presentation/bloc/auth_event.dart';
import 'package:my_movies/features/auth/presentation/bloc/auth_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthBloc>().add(AuthCheckRequested());
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.authenticated) {
            AppNavigator().pushReplacementNamed(AppRoutes.main);
          } else if (state.status == AuthStatus.unauthenticated) {
            AppNavigator().pushReplacementNamed(AppRoutes.login);
          }
        },
        builder: (context, state) {
          return HandlingDataRequest(
            requestState: _mapAuthStatusToRequestState(state.status),
            errorMessage: state.message,
            widget: const _SplashContent(),
          );
        },
      ),
    );
  }

  RequestState _mapAuthStatusToRequestState(AuthStatus status) {
    switch (status) {
      case AuthStatus.loading:
        return RequestState.loading;
      case AuthStatus.error:
        return RequestState.error;
      case AuthStatus.authenticated:
      case AuthStatus.unauthenticated:
        return RequestState.success;
      default:
        return RequestState.loading;
    }
  }
}

class _SplashContent extends StatelessWidget {
  const _SplashContent();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            ' Movie App',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: 20),
          CircularProgressIndicator(color: Colors.white),
        ],
      ),
    );
  }
}
