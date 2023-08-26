import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final String text;
  final Color? color;
  final VoidCallback? onPressed;

  const MenuButton({
    Key? key,
    required this.text,
    this.color,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Material(
      color: colorScheme.surface,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(29, 21, 29, 21),
          child: Text(
            text,
            style: textTheme.bodyMedium?.copyWith(
              color: color ?? colorScheme.onSurface,
              fontSize: 16,
              height: 1,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
