import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/theme_repository.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final ThemeRepository repository;

  ThemeCubit({required this.repository}) : super(ThemeMode.dark);

  Future<void> loadTheme() async {
    final themeMode = await repository.getCurrentTheme();
    emit(themeMode);
  }

  Future<void> changeTheme(ThemeMode themeMode) async {
    await repository.setTheme(themeMode);
    emit(themeMode);
  }
}
