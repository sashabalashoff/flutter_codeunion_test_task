import 'package:flutter/material.dart';

class ButtonGroup extends StatelessWidget {
  const ButtonGroup({
    super.key,
    this.buttons,
  });

  final List<Widget>? buttons;

  @override
  Widget build(BuildContext context) {
    if (buttons == null) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        for (final button in buttons!) ...[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: button,
          ),
          const SizedBox(height: 19),
        ],
      ],
    );
  }
}
