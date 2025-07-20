import 'package:flutter/material.dart';

abstract class ThemeRepository {
  Future<ThemeMode> getCurrentTheme();
  Future<void> setTheme(ThemeMode mode);
}
