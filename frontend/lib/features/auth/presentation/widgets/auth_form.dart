import 'package:flutter/material.dart';
import 'package:my_movies/features/auth/presentation/widgets/custom_text_form_auth.dart';

class AuthFormWidget extends StatelessWidget {
  final bool isLogin;
  final TextEditingController nameCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController passCtrl;

  const AuthFormWidget({
    super.key,
    required this.isLogin,
    required this.emailCtrl,
    required this.passCtrl,
    required this.nameCtrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!isLogin) ...[
          CustomTextFormField(
            hint: "Full Name",
            type: "username",
            controller: nameCtrl,
            icon: Icons.person,
          ),
          const SizedBox(height: 16),
        ],
        CustomTextFormField(
          hint: "Email Address",
          type: "email",
          controller: emailCtrl,
          icon: Icons.email,
        ),
        const SizedBox(height: 16),
        CustomTextFormField(
          hint: "Password",
          type: "password",
          controller: passCtrl,
          obscure: true,
          icon: Icons.lock,
          min: 6,
          max: 20,
        ),
      ],
    );
  }
}
