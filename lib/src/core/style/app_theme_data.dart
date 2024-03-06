import 'package:demarco_flutter_test/src/core/style/app_style_colors.dart';
import 'package:flutter/material.dart';

///[AppThemeData] classe que contém o tema padrão da aplicação
class AppThemeData {
  static ThemeData themeData = ThemeData(
    useMaterial3: true,
    primaryColor: AppStyleColors.primary,
    buttonTheme: ButtonThemeData(
        buttonColor: AppStyleColors.primary, highlightColor: AppStyleColors.primary),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: AppStyleColors.primary,
      actionsIconTheme: const IconThemeData(color: AppStyleColors.white),
      titleTextStyle: const TextStyle(color: AppStyleColors.white),
      iconTheme: const IconThemeData(
        color: AppStyleColors.white,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppStyleColors.primary,
      foregroundColor: AppStyleColors.white,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        overlayColor: const MaterialStatePropertyAll(AppStyleColors.white),
        foregroundColor: MaterialStatePropertyAll(AppStyleColors.primary),
      ),
    ),
    textTheme: const TextTheme(
      labelLarge: TextStyle(color: Colors.black),
    ),
  );
}
