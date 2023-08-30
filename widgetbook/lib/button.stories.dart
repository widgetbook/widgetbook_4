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
      // TODO: create knobs.metadata to avoid boilerplate
      text: context.knobs.string(
        label: knobs.textMetadata.name,
        description: knobs.textMetadata.description,
      ),
      color: context.knobs.color(
        label: knobs.textMetadata.name,
        description: knobs.textMetadata.description,
        initialValue: knobs.color,
      ),
    );
  },
);
