import 'package:flutter/material.dart';

import '../../domain/repositories/theme_repository.dart';
import '../datasources/theme_local_data_source.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final ThemeLocalDataSource localDataSource;

  ThemeRepositoryImpl({required this.localDataSource});

  @override
  Future<ThemeMode> getCurrentTheme() async {
    try {
      final themeMode = await localDataSource.getCachedTheme();
      return themeMode;
    } catch (e) {
      return ThemeMode.light;
    }
  }

  @override
  Future<void> setTheme(ThemeMode mode) async {
    try {
      await localDataSource.cacheTheme(mode);
    } catch (e) {
      rethrow;
    }
  }
}
