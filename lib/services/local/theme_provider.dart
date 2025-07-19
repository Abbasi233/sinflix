import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/services/local/shared_pref_provider.dart';

class ThemeProvider extends Cubit<ThemeMode> {
  ThemeProvider() : super(ThemeMode.light);

  Future<void> initialize() async {
    try {
      final String? themeString = SharedPrefProvider.I.getString(SharedKey.THEME);

      ThemeMode themeMode;
      if (themeString != null) {
        themeMode = ThemeMode.values.firstWhere(
          (e) => e.name == themeString,
          orElse: () => ThemeMode.light,
        );
      } else {
        themeMode = ThemeMode.light;
      }

      emit(themeMode);
    } catch (e) {
      emit(ThemeMode.light);
    }
  }

  Future<void> changeTheme(ThemeMode themeMode) async {
    try {
      await SharedPrefProvider.I.setString(SharedKey.THEME, themeMode.name);

      emit(themeMode);
    } catch (e) {
      rethrow;
    }
  }

  bool isDarkMode(BuildContext context) {
    if (state == ThemeMode.system) {
      return MediaQuery.of(context).platformBrightness == Brightness.dark;
    }

    return state == ThemeMode.dark;
  }
}
