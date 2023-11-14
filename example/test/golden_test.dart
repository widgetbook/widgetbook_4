import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart' hide ThemeMode;
import 'package:flutter_test/flutter_test.dart';
import 'package:fruits_app/button.dart';
import 'package:widgetbook_workspace/button.stories.dart';
import 'package:widgetbook_4/widgetbook_4.dart';

/// An extension that converts [WidgetbookScenario] to [GoldenTestScenario].
/// Will be replaced by more scalable solution in the future.
extension AlchemistConverter on WidgetbookScenario {
  GoldenTestScenario get alchemist => GoldenTestScenario.builder(
        name: story.name,
        builder: build,
      );
}

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
            ButtonScenario(
              story: $DefaultButton,
              modes: [],
              args: ButtonArgs(
                color: ColorArg(Colors.black),
                text: StringArg('Short'),
              ),
            ).alchemist,
            ButtonScenario(
              story: $DefaultButton,
              modes: [],
              args: ButtonArgs(
                color: ColorArg(Colors.black),
                text: StringArg('Very LongLongLongLongLong Text'),
              ),
            ).alchemist,
            ButtonScenario(
              // Most minimal scenario, args are extracted from story.
              story: $ArgLessButton,
            ).alchemist,
            ...ButtonScenario.matrix(
              story: $DefaultButton,
              modes: [
                [ThemeMode.value(ThemeData.dark())],
                [ThemeMode.value(ThemeData.light())]
              ],
              args: [
                ButtonArgs(
                  text: StringArg('Text'),
                  color: ColorArg(Colors.red),
                ),
                ButtonArgs(
                  text: StringArg('Text Or Not Text'),
                  color: ColorArg(Colors.black),
                ),
              ],
            ).map((e) => e.alchemist).toList(),
          ],
        ),
      );
    },
  );
}
