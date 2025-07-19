import 'package:get_it/get_it.dart';

import 'services/local/theme_provider.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerSingleton<ThemeProvider>(ThemeProvider());
}
