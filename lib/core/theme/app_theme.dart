import 'package:flutter/material.dart';

abstract final class AppColors {
  static const midnight = Color(0xFF07060F);
  static const aubergine = Color(0xFF1C0F33);
  static const abyss = Color(0xFF0A1B2C);
  static const orchid = Color(0xFFE58BFF);
  static const lagoon = Color(0xFF6FE3E1);
  static const moonlight = Color(0xFFF1EDFA);
  static const haze = Color(0xFFADA6C4);
}

abstract final class AppTheme {
  static final dark = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.orchid,
      brightness: Brightness.dark,
      surface: AppColors.midnight,
      primary: AppColors.orchid,
      secondary: AppColors.lagoon,
      onSurface: AppColors.moonlight,
    ),
    scaffoldBackgroundColor: AppColors.midnight,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 72,
        height: 1.05,
        fontWeight: FontWeight.w800,
        letterSpacing: -2,
      ),
      titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(fontSize: 18, height: 1.5, color: AppColors.haze),
    ),
  );
}
