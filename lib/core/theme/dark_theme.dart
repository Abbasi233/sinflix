import 'package:flutter/material.dart';

const Color blackColor = Color(0xFF0F0F0F);
const Color colora = Color.fromARGB(255, 233, 54, 170);
const Color colorb = Color.fromARGB(255, 230, 182, 171);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  // primaryColor: blackColor,
  // splashColor: colora,
  // canvasColor: colorb,
  useMaterial3: false,
  // textTheme: const TextTheme(
  //   labelLarge: TextStyle(color: Colors.white),
  //   bodySmall: TextStyle(color: Colors.white),
  //   bodyMedium: TextStyle(color: Colors.white),
  //   bodyLarge: TextStyle(color: Colors.white),
  //   titleSmall: TextStyle(color: Colors.white),
  //   titleMedium: TextStyle(color: Colors.white),
  //   titleLarge: TextStyle(color: Colors.white),
  //   headlineSmall: TextStyle(color: Colors.white),
  //   headlineMedium: TextStyle(color: Colors.white),
  //   headlineLarge: TextStyle(color: Colors.white),
  // ),
  radioTheme: const RadioThemeData(
    fillColor: WidgetStatePropertyAll(Colors.white),
    overlayColor: WidgetStatePropertyAll(Colors.white),
  ),
  scaffoldBackgroundColor: const Color(0xFF1E1E1E),
  primaryIconTheme: const IconThemeData(color: Colors.white60),
  unselectedWidgetColor: Colors.grey[300],
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1E1E1E),
    elevation: 0,
    centerTitle: true,
  ),
  cardTheme: CardThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    elevation: 3,
    clipBehavior: Clip.antiAliasWithSaveLayer,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF1E1E1E),
    selectedItemColor: Colors.red,
    unselectedItemColor: Colors.grey,
  ),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.only(top: 22, left: 10),
    labelStyle: const TextStyle(color: Colors.white),
    fillColor: Colors.transparent,
    filled: true,
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(24),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(24)),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(24)),
    ),
  ),
  dividerColor: Colors.grey,
);
