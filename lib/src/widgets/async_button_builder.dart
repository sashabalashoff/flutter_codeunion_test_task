import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef AsyncOrVoidCallback = FutureOr<void> Function();

class AsyncButtonBuilder extends StatefulWidget {
  const AsyncButtonBuilder({
    super.key,
    required this.onPressed,
    required this.builder,
  });

  final AsyncOrVoidCallback? onPressed;
  final Widget Function(
    BuildContext context,
    AsyncCallback? callback,
  ) builder;

  @override
  State<AsyncButtonBuilder> createState() => _AsyncButtonBuilderState();
}

class _AsyncButtonBuilderState extends State<AsyncButtonBuilder> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final onPressed = widget.onPressed;

    return widget.builder(
      context,
      onPressed == null || _isLoading
          ? null
          : () async {
              final dynamic result = onPressed();
              if (result is Future) {
                setState(() {
                  _isLoading = true;
                });
                try {
                  await result;
                } catch (_) {
                  rethrow;
                } finally {
                  if (mounted) {
                    setState(() {
                      _isLoading = false;
                    });
                  }
                }
              }
            },
    );
  }
}
