import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies/config/routes.dart';
import 'package:my_movies/core/widgets/handling_data_request.dart';
import 'package:my_movies/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:my_movies/features/auth/presentation/bloc/auth_event.dart';
import 'package:my_movies/features/auth/presentation/bloc/auth_state.dart';
import 'auth_page_base.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          Navigator.pushReplacementNamed(context, AppRoutes.main);
        } else if (state.status == AuthStatus.error) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message ?? 'Error')));
        }
      },
      builder: (context, state) {
        final requestState = state.status == AuthStatus.loading
            ? RequestState.loading
            : (state.status == AuthStatus.error
                  ? RequestState.error
                  : RequestState.success);

        return AuthPageBase(
          title: 'Register',
          isLogin: false,
          formKey: _formKey,
          emailCtrl: _emailCtrl,
          passCtrl: _passCtrl,
          nameCtrl: _nameCtrl,
          requestState: requestState,
          errorMessage: state.message,
          onSubmit: () {
            if (_formKey.currentState!.validate()) {
              context.read<AuthBloc>().add(
                AuthRegisterRequested(
                  _nameCtrl.text.trim(),
                  _emailCtrl.text.trim(),
                  _passCtrl.text.trim(),
                ),
              );
            }
          },
          onNavigateToOtherPage: () =>
              Navigator.pushNamed(context, AppRoutes.login),
        );
      },
    );
  }
}
