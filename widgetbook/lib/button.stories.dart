import 'package:flutter/material.dart';
import 'package:fruits_app/button.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_fruits_app/button.stories.g.dart';
import 'package:widgetbook_fruits_app/widgetbook_4.dart';

const metadata = ComponentMetadata(
  name: 'Button 4',
  type: Button,
  description: 'A button to click on.',
);

final story = ButtonStory(
  setup: () {
    print('Setup');
  },
  knobs: ButtonKnobs(
    color: Colors.black,
    text: 'Text',
  ),
  builder: (context, knobs) {
    return Button(
      text: context.knobs.string(label: 'Text'),
      color: context.knobs.color(
        label: 'Color',
        initialValue: knobs.color,
      ),
    );
  },
);
