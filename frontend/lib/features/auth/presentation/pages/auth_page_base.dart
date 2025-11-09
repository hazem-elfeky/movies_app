import 'package:flutter/material.dart';
import 'package:my_movies/features/auth/presentation/widgets/auth_card_header.dart';
import 'package:my_movies/features/auth/presentation/widgets/auth_form.dart';
import 'package:my_movies/core/widgets/handling_data_request.dart';

class AuthPageBase extends StatelessWidget {
  final String title;
  final bool isLogin;
  final TextEditingController emailCtrl;
  final TextEditingController passCtrl;
  final TextEditingController? nameCtrl;
  final GlobalKey<FormState> formKey;
  final void Function() onSubmit;
  final void Function() onNavigateToOtherPage;
  final RequestState requestState;
  final String? errorMessage;

  const AuthPageBase({
    super.key,
    required this.title,
    required this.isLogin,
    required this.emailCtrl,
    required this.passCtrl,
    this.nameCtrl,
    required this.formKey,
    required this.onSubmit,
    required this.onNavigateToOtherPage,
    required this.requestState,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return HandlingDataRequest(
      requestState: requestState,
      errorMessage: errorMessage,
      widget: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              AuthCardHeader(title: title),
              AuthFormWidget(
                isLogin: isLogin,
                nameCtrl: nameCtrl ?? TextEditingController(),
                emailCtrl: emailCtrl,
                passCtrl: passCtrl,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onSubmit,
                child: Text(title, style: const TextStyle(fontSize: 18)),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: onNavigateToOtherPage,
                child: Text(
                  isLogin
                      ? "Don't have an account? Register"
                      : "Already have an account? Login",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
