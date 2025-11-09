import 'package:flutter/material.dart';
import 'package:my_movies/config/app_colors.dart';
import 'package:my_movies/core/utils/validatrors.dart';

class CustomTextFormField extends StatelessWidget {
  final String hint;
  final String type;
  final TextEditingController controller;
  final bool obscure;
  final IconData? icon;
  final int min;
  final int max;

  const CustomTextFormField({
    super.key,
    required this.hint,
    required this.type,
    required this.controller,
    this.obscure = false,
    this.icon,
    this.min = 3,
    this.max = 30,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: (val) => validInput(val, min, max, type),
      style: TextStyle(color: colorScheme.onSurface),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.surfaceColor,
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white70),
        prefixIcon: icon != null
            ? Icon(icon, color: AppColors.primaryColor)
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: AppColors.primaryColor,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.amberAccent, width: 2.0),
        ),
      ),
    );
  }
}
