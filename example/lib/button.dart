import 'package:flutter/material.dart';

/// A button to click on.
class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.text,
    required this.color,
  });

  /// The text of this button.
  final String text;

  /// The background color of this button.
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Text(text),
    );
  }
}
