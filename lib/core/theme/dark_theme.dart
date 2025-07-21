import 'package:flutter/material.dart';

import '/core/colors.dart';
import '/core/text_styles.dart';

final darkTheme = ThemeData(
  useMaterial3: false,
  brightness: Brightness.dark,
  textTheme: TextTheme(
    labelLarge: TextStyles.labelLarge,
    labelMedium: TextStyles.labelMedium,
    bodySmall: TextStyles.bodySmall,
    bodyMedium: TextStyles.bodyMedium,
    bodyLarge: TextStyles.bodyLarge,
    titleSmall: TextStyles.titleSmall,
    titleMedium: TextStyles.titleMedium,
    titleLarge: TextStyles.titleLarge,
    headlineMedium: TextStyles.headlineMedium,
    headlineLarge: TextStyles.headlineLarge,
  ),
  radioTheme: const RadioThemeData(
    fillColor: WidgetStatePropertyAll(Colors.white),
    overlayColor: WidgetStatePropertyAll(Colors.white),
  ),
  scaffoldBackgroundColor: AppColors.darkBackground,
  primaryIconTheme: const IconThemeData(color: Colors.white60),
  unselectedWidgetColor: Colors.grey[300],
  appBarTheme: AppBarTheme(
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyles.titleMedium,
    backgroundColor: AppColors.darkBackground,
    iconTheme: const IconThemeData(color: Colors.white),
  ),
  cardTheme: CardThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    elevation: 3,
    clipBehavior: Clip.antiAliasWithSaveLayer,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF1E1E1E),
    selectedItemColor: Colors.red,
    unselectedItemColor: Colors.grey,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.darkInputFill,
    focusColor: AppColors.accent,
    prefixIconConstraints: const BoxConstraints.expand(width: 26),
    hintStyle: TextStyle(color: Colors.white.withAlpha(128)),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: AppColors.darkBorder),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.accent),
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.darkBorder),
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
  ),
  dividerColor: Colors.grey,
);
