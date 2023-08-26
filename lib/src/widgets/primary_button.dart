import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

import '../res/utils/extensions.dart';

class PrimaryButton extends StatefulWidget {
  static double get defaultHeight => 64;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.height,
    this.margin = EdgeInsets.zero,
    this.isActive = true,
  });

  final String text;
  final FutureOr<void> Function() onPressed;
  final Color? color;
  final double? height;
  final EdgeInsets margin;
  final bool isActive;

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  final _isLoading = BehaviorSubject.seeded(false);

  @override
  void dispose() {
    _isLoading.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final height = widget.height ?? PrimaryButton.defaultHeight;
    final color = widget.color ?? colorScheme.primary;

    return Padding(
      padding: widget.margin,
      child: Opacity(
        opacity: widget.isActive ? 1.0 : 0.5,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
          ),
          child: Material(
            color: color,
            borderRadius: BorderRadius.circular(6),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: !widget.isActive
                  ? null
                  : () async {
                      final dynamic result = widget.onPressed();
                      if (result is Future) {
                        _isLoading.value = true;
                        try {
                          await result;
                        } catch (_) {
                          rethrow;
                        } finally {
                          _isLoading.maybeAdd(false);
                        }
                      }
                    },
              child: Container(
                height: height,
                alignment: Alignment.center,
                child: StreamBuilder<bool>(
                  stream: _isLoading,
                  builder: (context, snapshot) {
                    final isLoading = snapshot.data ?? false;
                    if (isLoading) {
                      return Padding(
                        padding: const EdgeInsets.all(6),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final maxWidth = constraints.maxWidth;
                            final maxHeight = constraints.maxHeight;
                            final size = math.min(maxWidth, maxHeight);

                            return SizedBox(
                              width: size,
                              height: size,
                              child: CircularProgressIndicator(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                  widget.text,
                                  style: textTheme.titleMedium?.copyWith(
                                    color: colorScheme.onPrimary,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
