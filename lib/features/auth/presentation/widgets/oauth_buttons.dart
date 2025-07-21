import 'package:flutter/material.dart';

import '/core/colors.dart';

class OAuthButton extends StatelessWidget {
  final String imgPath;
  final VoidCallback? onPressed;

  const OAuthButton({
    super.key,
    required this.imgPath,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDarkMode ? AppColors.darkBorder : AppColors.lightBorder,
            width: 1,
          ),
          color: isDarkMode ? AppColors.darkInputFill : AppColors.lightInputFill,
        ),
        child: Center(
          child: Image.asset(
            imgPath,
            width: 24,
            height: 24,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
