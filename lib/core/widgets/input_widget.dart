import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextFormField extends StatelessWidget {
  final BuildContext context;
  final String label;
  final String? hintText;
  final Color color;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final bool readOnly;
  final void Function()? onTap;
  final TextInputType? keyboardType;
  final TextInputFormatter? inputFormatter;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  final int? maxLength;

  const AppTextFormField(
    this.context, {
    required this.label,
    required this.color,
    required this.controller,
    this.hintText,
    this.validator,
    this.onTap,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.readOnly = false,
    this.inputFormatter,
    this.onChanged,
    this.maxLength,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onTap: onTap,
      validator: validator,
      obscureText: obscureText,
      onChanged: onChanged,
      keyboardType: keyboardType,
      readOnly: readOnly,
      maxLength: maxLength,
      textInputAction: TextInputAction.next,
      inputFormatters: inputFormatter != null ? [inputFormatter!] : null,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: color,
        labelText: label,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
