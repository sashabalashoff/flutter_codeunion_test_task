import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'async_button_builder.dart';

class CustomButton extends StatelessWidget {
  static double get defaultHeight => 64;

  const CustomButton({
    super.key,
    this.svgIcon,
    required this.text,
    this.textStyle,
    this.subtitle,
    this.onPressed,
    this.color,
    this.overlayColor,
    this.height,
    this.margin = EdgeInsets.zero,
    this.borderRadius = const BorderRadius.all(Radius.circular(6)),
    this.isActive = true,
    this.boxShadow,
    this.gradient,
  });

  final String? svgIcon;
  final String text;
  final TextStyle? textStyle;
  final String? subtitle;
  final AsyncOrVoidCallback? onPressed;
  final Color? color;
  final Color? overlayColor;
  final double? height;
  final EdgeInsets margin;
  final BorderRadius borderRadius;
  final bool isActive;
  final List<BoxShadow>? boxShadow;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final svgIcon = this.svgIcon;
    final subtitle = this.subtitle;
    final height = this.height ?? CustomButton.defaultHeight;
    final color = this.color ?? colorScheme.primary;
    final overlayColor = this.overlayColor;

    return Padding(
      padding: margin,
      child: AnimatedOpacity(
        duration: kThemeChangeDuration,
        opacity: isActive ? 1.0 : 1,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            boxShadow: boxShadow,
          ),
          child: Material(
            color: color,
            borderRadius: borderRadius,
            clipBehavior: Clip.antiAlias,
            child: AsyncButtonBuilder(
              onPressed: onPressed,
              builder: (context, callback) {
                return InkWell(
                  overlayColor:
                      overlayColor != null ? MaterialStateProperty.all(overlayColor) : null,
                  onTap: !isActive ? null : callback,
                  child: Container(
                    height: height,
                    decoration: BoxDecoration(gradient: gradient),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (svgIcon != null)
                                Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: SvgPicture.string(svgIcon),
                                ),
                              Flexible(
                                child: Text(
                                  text,
                                  style: textStyle ??
                                      textTheme.bodyMedium?.copyWith(
                                        color: colorScheme.onPrimary,
                                        fontWeight: FontWeight.w700,
                                        height: 1,
                                      ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          if (subtitle != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 1),
                              child: Text(
                                subtitle,
                                style: textTheme.bodySmall?.copyWith(
                                  color: colorScheme.onPrimary.withOpacity(0.7),
                                  fontSize: 11,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
