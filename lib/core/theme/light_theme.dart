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
    headlineLarge: TextStyles.headlineLarge,
    headlineMedium: TextStyles.headlineMedium,
    titleLarge: TextStyles.titleLarge,
    titleMedium: TextStyles.titleMedium,
    bodyLarge: TextStyles.bodyLarge,
    bodyMedium: TextStyles.bodyMedium,
    bodySmall: TextStyles.bodySmall,
    labelLarge: TextStyles.labelLarge,
    labelMedium: TextStyles.labelMedium,
  ),
  // colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
  scaffoldBackgroundColor: AppColors.background,
  unselectedWidgetColor: AppColors.border,
  canvasColor: AppColors.card,
  appBarTheme: AppBarTheme(
    iconTheme: const IconThemeData(color: Colors.black),
    backgroundColor: AppColors.background,
    elevation: 1,
    centerTitle: true,
    titleTextStyle: TextStyles.headlineMedium,
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
        color: AppColors.primaryText,
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
    contentPadding: const EdgeInsets.only(top: 22, left: 10),
    labelStyle: const TextStyle(color: AppColors.secondaryText),
    fillColor: Colors.transparent,
    filled: true,
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(24),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(24)),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(24)),
    ),
  ),
  dividerColor: Colors.grey[900],
);
