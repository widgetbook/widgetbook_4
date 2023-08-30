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
  args: ButtonArgs(
    color: Colors.black,
    text: 'Text',
  ),
  builder: (context, args) {
    return Button(
      // TODO: create knobs.metadata to avoid boilerplate
      text: context.knobs.string(
        label: args.textMetadata.name,
        description: args.textMetadata.description,
      ),
      color: context.knobs.color(
        label: args.textMetadata.name,
        description: args.textMetadata.description,
        initialValue: args.color,
      ),
    );
  },
);
