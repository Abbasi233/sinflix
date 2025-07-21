import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/core/colors.dart';
import '/core/asset_paths.dart';

class AppTextFormField extends StatelessWidget {
  final BuildContext context;
  final TextEditingController controller;
  final String? hintText;
  final String? Function(String?)? validator;
  final bool isObscurable;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? prefixSvgPath;
  final TextCapitalization textCapitalization;

  AppTextFormField(
    this.context, {
    required this.controller,
    this.hintText,
    this.validator,
    this.prefixSvgPath,
    this.isObscurable = false,
    this.inputFormatters,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    super.key,
  });

  final _showPassword = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return AnimatedBuilder(
      animation: _showPassword,
      builder: (context, _) {
        return TextFormField(
          controller: controller,
          validator: validator,
          obscureText: isObscurable ? !_showPassword.value : false,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          textCapitalization: textCapitalization,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            prefixIcon: prefixSvgPath != null
                ? Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Image.asset(
                        prefixSvgPath!,
                        width: 16,
                        height: 16,
                        fit: BoxFit.scaleDown,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  )
                : null,
            prefixIconConstraints: const BoxConstraints.expand(width: 55),
            contentPadding: const EdgeInsets.only(left: 50, right: 10),
            suffixIcon: isObscurable
                ? GestureDetector(
                    onTap: () => _showPassword.value = !_showPassword.value,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 30),
                      child: Image.asset(
                        AssetPaths.hideImg,
                        width: 16,
                        height: 16,
                        fit: BoxFit.scaleDown,
                        color: _showPassword.value
                            ? AppColors.accent
                            : isDark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  )
                : null,
            hintText: hintText,
            errorStyle: const TextStyle(height: 0, fontSize: 0),
            errorText: null,
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(8),
            ),
            constraints: const BoxConstraints(
              minHeight: 55,
              maxHeight: 55,
            ),
          ),
        );
      },
    );
  }
}
