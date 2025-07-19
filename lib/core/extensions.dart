import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat, NumberFormat;

import '/core/colors.dart';

extension AppContextExtension on BuildContext {
  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;

  bool get isRTL => Directionality.of(this) == TextDirection.rtl;

  bool get isLTR => Directionality.of(this) == TextDirection.ltr;

  TextDirection get textDirection => Directionality.of(this);

  bool get isArabic => Localizations.localeOf(this).languageCode == 'ar';

  SizedBox emptyW(double width) => SizedBox(width: width);

  SizedBox emptyH(double height) => SizedBox(height: height);

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  Divider get divider => const Divider(height: 0, thickness: 0.3, color: Colors.grey);

  Future<T?> showPopUp<T>(Widget dialog) {
    return showDialog(context: this, builder: (context) => dialog);
  }

  void showSnackBar(String message, {Color? color, bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: kBottomNavigationBarHeight + 16),
        content: Text(message, style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white)),
        backgroundColor: isError ? AppColors.negative : color ?? AppColors.positive,
        duration: Duration(seconds: isError ? 4 : 2),
      ),
      snackBarAnimationStyle: const AnimationStyle(curve: Curves.easeInOut),
    );
  }

  void callAfterBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) => callback());
  }

  Future<T?> push<T>(Widget page) => Navigator.of(this).push<T?>(MaterialPageRoute(builder: (_) => page));

  void replacement(Widget page) => Navigator.of(this).pushReplacement(MaterialPageRoute(builder: (_) => page));

  void pop<T>([T? result]) => Navigator.of(this).pop(result);
}

extension ObjectExtension on Object? {
  bool get isNullOrEmpty {
    if (this == null) return true;

    if ((this is String) && this == '') return true;

    if ((this is bool) && this == false) return true;

    if (this is List) return (this as List).isEmpty;

    return false;
  }
}

extension ThemeExtension on ThemeData {
  LinearGradient get lightGradient => const LinearGradient(colors: [Color.fromARGB(255, 233, 54, 170), Color.fromARGB(255, 230, 182, 171)]);

  LinearGradient get darkGradient => const LinearGradient(colors: [Color(0xFFc31432), Color(0xFF240b36)]);
  LinearGradient get lightGradientBottom => const LinearGradient(colors: [Color.fromARGB(255, 233, 54, 170), Color(0xFFEEF0F4)], begin: Alignment.topCenter, end: Alignment.bottomCenter);

  LinearGradient get darkGradientTop => const LinearGradient(colors: [Color(0xFF240b36), Color(0xFF1E1E1E)], begin: Alignment.topCenter, end: Alignment.bottomCenter);
  LinearGradient get lightGradientShop => const LinearGradient(
    colors: [
      Color.fromARGB(255, 255, 249, 215), // Açık sarı
      Color.fromARGB(255, 255, 255, 255), // Beyaz
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  LinearGradient get lightGradientShopCard => const LinearGradient(
    colors: [
      Color.fromARGB(255, 255, 249, 170),
      Color.fromARGB(255, 255, 255, 255), // Beyaz
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  LinearGradient get lightGradientLevel => const LinearGradient(
    colors: [
      Color.fromARGB(255, 255, 249, 170),
      Color.fromARGB(255, 255, 255, 255), // Beyaz
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

extension StringExtension on String {
  String get capitalize => '${this[0].toUpperCase()}${substring(1)}';

  String maxChars(int length) => length < this.length ? substring(0, length) : this;
}

extension DateTimeExtension on DateTime? {
  String toReadableString() {
    if (this == null) return 'Bilinmiyor';
    return DateFormat('dd/MM/yyyy').format(this!);
  }
}

extension IntExtension on int {
  String get compact {
    return NumberFormat.compact().format(this);
  }
}
