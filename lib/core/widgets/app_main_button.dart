import 'package:flutter/material.dart';
import 'package:sinflix/core/extensions.dart';
import '../colors.dart';

class AppMainButton extends ElevatedButton {
  final String text;

  AppMainButton(
    BuildContext context, {
    required super.onPressed,
    required this.text,
    super.key,
  }) : super(
         style: ElevatedButton.styleFrom(
           elevation: 0,
           backgroundColor: AppColors.accent,
           foregroundColor: Colors.white,
           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
           minimumSize: const Size(double.infinity, 54),
         ),
         child: Text(text, style: context.textTheme.titleMedium?.copyWith(color: Colors.white)),
       );
}
