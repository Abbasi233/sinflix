import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import 'core/theme/light_theme.dart';
import 'core/theme/dark_theme.dart';
import 'injection/injection_container.dart' as di;
import 'features/theme/presentation/bloc/theme_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await di.init();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('tr', 'TR'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<ThemeCubit>()..loadTheme(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, state) {
          return MaterialApp(
            title: 'SinFlix',
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: state,
            home: const MyHomePage(title: 'SinFlix Demo'),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          PopupMenuButton<ThemeMode>(
            icon: const Icon(Icons.brightness_6),
            onSelected: (ThemeMode themeMode) {
              context.read<ThemeCubit>().changeTheme(themeMode);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: ThemeMode.light,
                child: Text('Açık Tema'),
              ),
              const PopupMenuItem(
                value: ThemeMode.dark,
                child: Text('Koyu Tema'),
              ),
              const PopupMenuItem(
                value: ThemeMode.system,
                child: Text('Sistem'),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Butona kaç kez bastınız:'),
            const SizedBox(height: 20),
            BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, state) {
                String themeName = state.name.toUpperCase();

                return Card(
                  margin: const EdgeInsets.all(16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const Text('Mevcut Tema:', style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text(themeName),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
