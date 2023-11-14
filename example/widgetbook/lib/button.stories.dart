import 'package:flutter/material.dart';
import 'package:fruits_app/button.dart';
import 'package:widgetbook_4/widgetbook_4.dart';

part 'button.stories.g.dart';

const metadata = ComponentMetadata(
  type: Button,
  name: 'Button 4',
  description: 'A button to click on.',
  documentation: '''
  Lorem **ipsum** _dolor_ sit amet, consectetur adipiscing elit.
   1. Nullam euismod, nisl eget aliquam ultricies, quam odio
      luctus nunc, nec aliquam diam diam ut risus.
   2. Nulla facilisi. nisl eget aliquam ultricies.
  ''',
);

final $DefaultButton = ButtonStory(
  name: 'Default',
  designUrl: 'https://www.figma.com/file/...',
  args: ButtonArgs(
    // If no name or description is provided, the name of the field will be used
    // as name and the doc comment of the field will be used as description.
    text: StringArg('Press'),
    // Alternate syntaxes to explore:
    // - color: ($) => Colors.red
    // - color: ($) => $.add(ColorArg(...))
    // - color: Arg.value(Colors.red)
    // - color: Arg.knob(Knob(...))
    color: ColorArg(
      Colors.red,
      name: 'Background Color',
      description: 'The background color of this button.',
    ),
  ),
);
