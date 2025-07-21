import 'package:flutter/material.dart';
import 'package:sinflix/core/colors.dart';
import 'package:auto_route/auto_route.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        context.router.maybePop();
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isDarkMode ? AppColors.darkInputFill : AppColors.lightInputFill,
          border: Border.all(
            color: isDarkMode ? AppColors.darkBorder : AppColors.lightBorder,
          ),
        ),
        child: const Icon(Icons.arrow_back, size: 24),
      ),
    );
  }
}
