import 'package:flutter/material.dart';
import 'package:fruits_app/button.dart';
import 'package:widgetbook/widgetbook.dart';

import 'widgetbook_4.dart';

part 'button.stories.g.dart';

const metadata = ComponentMetadata(
  name: 'Button 4',
  type: Button,
  description: 'A button to click on.',
);

final buttonStory = ButtonStory(
  name: 'Default',
  setup: () {
    print('Setup');
  },
  knobs: ButtonKnobs(
    color: Colors.black,
    text: 'Text',
  ),
  builder: (context, knobs) {
    return Button(
      text: context.knobs.string(
        label: 'Text',
      ),
      color: context.knobs.color(
        label: 'Color',
        initialValue: knobs.color,
      ),
    );
  },
);
