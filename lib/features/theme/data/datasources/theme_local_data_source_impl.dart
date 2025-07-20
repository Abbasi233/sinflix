import 'package:flutter/material.dart';
import '../../../../core/storage/local_storage_service.dart';
import 'theme_local_data_source.dart';

class ThemeLocalDataSourceImpl implements ThemeLocalDataSource {
  final LocalStorageService localStorageService;

  ThemeLocalDataSourceImpl({required this.localStorageService});

  @override
  Future<ThemeMode> getCachedTheme() async {
    try {
      final themeString = await localStorageService.getString(StorageKey.theme.name);

      if (themeString != null) {
        return ThemeMode.values.firstWhere(
          (e) => e.name == themeString,
          orElse: () => ThemeMode.light,
        );
      }

      return ThemeMode.light;
    } catch (e) {
      return ThemeMode.light;
    }
  }

  @override
  Future<void> cacheTheme(ThemeMode themeMode) async {
    await localStorageService.setString(StorageKey.theme.name, themeMode.name);
  }
}
