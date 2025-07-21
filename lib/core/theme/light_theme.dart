import 'package:flutter/material.dart';

import '/core/colors.dart';
import '/core/text_styles.dart';

final lightTheme = ThemeData(
  useMaterial3: false,
  brightness: Brightness.light,
  primaryColor: AppColors.primary,
  primaryColorDark: Colors.black87,
  primaryColorLight: AppColors.primary,
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
  scaffoldBackgroundColor: AppColors.lightBackground,
  unselectedWidgetColor: AppColors.border,
  canvasColor: AppColors.card,
  appBarTheme: AppBarTheme(
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyles.titleMedium.copyWith(color: Colors.black),
    backgroundColor: AppColors.lightBackground,
    iconTheme: const IconThemeData(color: Colors.black),
  ),
  cardTheme: CardThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    elevation: 3,
    clipBehavior: Clip.antiAliasWithSaveLayer,
  ),
  radioTheme: const RadioThemeData(
    fillColor: WidgetStatePropertyAll(Colors.black),
    overlayColor: WidgetStatePropertyAll(Colors.black),
  ),
  dividerTheme: const DividerThemeData(color: AppColors.border),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      side: const BorderSide(
        width: 1,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    ),
  ),
  primaryIconTheme: const IconThemeData(color: Colors.black54),
  buttonTheme: const ButtonThemeData(buttonColor: Colors.black),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.primary,
    unselectedItemColor: AppColors.secondaryText,
    selectedItemColor: AppColors.accent,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.lightInputFill,
    focusColor: AppColors.accent,
    prefixIconConstraints: const BoxConstraints.expand(width: 26),
    hintStyle: TextStyle(color: Colors.black.withAlpha(128)),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: AppColors.lightBorder),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.accent),
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.lightBorder),
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
  ),
  dividerColor: Colors.grey[900],
);
