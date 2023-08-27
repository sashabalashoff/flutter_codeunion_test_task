import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? hintText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;

  const CustomInput({
    Key? key,
    this.controller,
    this.onChanged,
    this.hintText,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return TextField(
      controller: controller,
      style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface),
      onChanged: onChanged,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      decoration: InputDecoration(
        border: InputBorder.none,
        fillColor: colorScheme.surface,
        filled: true,
        hintText: hintText,
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: theme.brightness == Brightness.light
              ? const Color(0xFFC3C3C3)
              : const Color(0xFFC3C3C3),
        ),
      ),
    );
  }
}
