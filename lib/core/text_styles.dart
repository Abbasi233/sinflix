import 'package:flutter/material.dart';

import '/core/colors.dart';

class TextStyles {
  static const String _fontFamily = 'Euclid Circular A';

  static TextStyle headlineLarge = const TextStyle(
    fontFamily: _fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );

  static TextStyle headlineMedium = const TextStyle(
    fontFamily: _fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static TextStyle titleLarge = const TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static TextStyle titleMedium = const TextStyle(
    fontFamily: _fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w500,
  );

  static TextStyle titleSmall = const TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  static TextStyle bodyLarge = const TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
  );

  static TextStyle bodyMedium = const TextStyle(
    fontFamily: _fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.w400,
  );

  static TextStyle bodySmall = const TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  static TextStyle labelLarge = const TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  static TextStyle labelMedium = const TextStyle(
    fontFamily: _fontFamily,
    fontSize: 13,
    color: AppColors.secondaryText,
  );
}
