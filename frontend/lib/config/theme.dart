import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';

final ThemeData appTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.primaryColor,
  scaffoldBackgroundColor: AppColors.backgroundColor,

  colorScheme: const ColorScheme.dark(
    primary: AppColors.primaryColor,
    secondary: AppColors.secondaryColor,
    background: AppColors.backgroundColor,
    surface: AppColors.surfaceColor,
    error: AppColors.errorColor,
    onPrimary: AppColors.onPrimaryColor,
    onSecondary: AppColors.onSecondaryColor,
    onSurface: AppColors.onSurfaceColor,
    onBackground: AppColors.onBackgroundColor,
  ),

  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.surfaceColor,
    foregroundColor: AppColors.onSurfaceColor,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: AppColors.onBackgroundColor,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(color: AppColors.primaryColor),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: AppColors.onPrimaryColor,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 32),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.surfaceColor,
    contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.5),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.amberAccent, width: 2),
    ),
    labelStyle: const TextStyle(color: AppColors.onSurfaceColor),
    hintStyle: const TextStyle(color: Colors.white70),
  ),

  textTheme: const TextTheme(
    bodyLarge: TextStyle(fontSize: 16, color: AppColors.onBackgroundColor),
    bodyMedium: TextStyle(fontSize: 14, color: AppColors.onBackgroundColor),
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: AppColors.onBackgroundColor,
    ),
  ),
);
