import 'package:flutter/material.dart';
import 'package:fruits_app/button.dart';
import 'package:widgetbook_4/widgetbook_4.dart';

part 'button.stories.g.dart';

const metadata = ComponentMetadata(
  name: 'Button 4',
  type: Button,
  description: 'A button to click on.',
);

final defaultButton = ButtonStory(
  name: 'Default',
  setup: () => print('Mocking'),
  args: ButtonArgs(
    // Alternate syntaxes to explore:
    // color: ($) => Colors.red,
    // color: ($) => $.add(ColorArg(...)),
    // color: Arg.value(Colors.red),
    // color: Arg.knob(Knob(...)),
    color: ColorArg(
      Colors.red,
      name: 'Background Color',
      description: 'The background color of this button.',
    ),
    // If no name or description is provided, the name of the field will be used
    // as name and the doc comment of the field will be used as description.
    text: StringArg('Press'),
  ),
);
