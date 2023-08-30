import 'package:flutter/material.dart';
import 'package:fruits_app/button.dart';
import 'package:widgetbook_fruits_app/widgetbook_4.dart';

class ButtonStory extends WidgetbookStory {
  ButtonStory({
    required super.setup,
    required super.knobs,
    required super.builder,
  });
}

class ButtonKnobs extends WidgetbookKnobs {
  ButtonKnobs({
    required this.text,
    required this.color,
  });

  final String text;
  final Color color;

  Widget build(BuildContext context) {
    return Button(
      text: text,
      color: color,
    );
  }
}
