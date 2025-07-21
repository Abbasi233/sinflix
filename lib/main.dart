import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sinflix/features/dashboard/presentation/bloc/movie_bloc.dart';

import 'core/theme/dark_theme.dart';
import 'core/theme/light_theme.dart';
import 'core/navigation/app_router.dart';
import 'core/service_locator.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/theme/presentation/bloc/theme_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await initServiceLocator();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider.value(value: sl<ThemeCubit>()..loadTheme()),
        BlocProvider.value(value: sl<AuthBloc>()..add(const CheckAuthEvent())),
        BlocProvider.value(value: sl<MovieBloc>()),
      ],
      child: EasyLocalization(
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('tr', 'TR'),
        ],
        path: 'assets/translations',
        startLocale: const Locale('tr', 'TR'),
        fallbackLocale: const Locale('en', 'US'),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp.router(
          title: 'SinFlix',
          routerConfig: sl<AppRouter>().config(),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeMode,
        );
      },
    );
  }
}
