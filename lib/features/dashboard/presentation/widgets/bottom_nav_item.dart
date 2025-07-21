import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sinflix/core/colors.dart';
import 'package:sinflix/core/extensions.dart';

class BottomNavItem extends StatelessWidget {
  const BottomNavItem({super.key, required this.iconPath, required this.onTap, required this.title});
  final String title;
  final String iconPath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.theme.brightness == Brightness.dark;
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        width: 125,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(color: isDarkMode ? AppColors.darkBorder : AppColors.lightBorder),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconPath,
              width: 28,
              height: 28,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            const Gap(8),
            Text(title, style: context.textTheme.titleSmall),
          ],
        ),
      ),
    );
  }
}
