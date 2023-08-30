import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fruits_app/button.dart';
import 'package:widgetbook_workspace/button.stories.dart';
import 'package:widgetbook_workspace/widgetbook_4.dart';

void main() {
  group(
    '$Button Golden Tests',
    () {
      goldenTest(
        'renders correctly',
        fileName: '$Button',
        builder: () => GoldenTestGroup(
          children: [
            // The [ButtonScenario] is used with different combination of addons
            // and knobs to generate different scenarios.
            buttonStory.toScenario(
              addons: [],
              args: ButtonArgs(
                text: 'Short',
                color: Colors.black,
              ),
            ).scenario,
            buttonStory.toScenario(
              addons: [],
              args: ButtonArgs(
                text: 'Very LongLongLongLongLong Text',
                color: Colors.black,
              ),
            ).scenario,
          ],
        ),
      );
    },
  );
}

/// An extension that converts [WidgetbookScenario] to [GoldenTestScenario].
/// Will be replaced by more scalable solution in the future.
extension AlchemistConverter on WidgetbookScenario {
  GoldenTestScenario get scenario => GoldenTestScenario.builder(
        name: story.name,
        builder: build,
      );
}
