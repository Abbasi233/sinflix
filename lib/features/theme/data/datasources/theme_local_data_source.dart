import 'package:flutter/material.dart';

abstract class ThemeLocalDataSource {
  Future<ThemeMode> getCachedTheme();
  Future<void> cacheTheme(ThemeMode themeMode);
}
