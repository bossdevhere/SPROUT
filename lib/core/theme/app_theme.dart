import 'package:flutter/material.dart';
import 'package:sprout/core/constants/app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.softPurple,
        primary: AppColors.softPurple,
        secondary: AppColors.skyBlue,
        tertiary: AppColors.mintGreen,
        surface: AppColors.background,
      ),
      scaffoldBackgroundColor: AppColors.background,
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        color: AppColors.white,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: AppColors.darkText,
        ),
        titleLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppColors.darkText,
        ),
        bodyLarge: TextStyle(
          fontSize: 18,
          color: AppColors.darkText,
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          color: AppColors.lightText,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.softPurple,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
