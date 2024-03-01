import 'package:demarco_flutter_test/src/core/style/app_style_colors.dart';
import 'package:flutter/material.dart';

class AppThemeData {
  static ThemeData themeData = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: AppStyleColors.primary,
      actionsIconTheme: const IconThemeData(
        color: Colors.white,
      ),
      titleTextStyle: const TextStyle(color: Colors.white),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
    ),
  );
}
