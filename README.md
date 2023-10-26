# Widgetbook 4: A Clean Slate

## Widgetbook 3 Problems

1. Use-cases are **not reusable for tests**, they cannot be easily used for golden or widget tests.
2. Mocking use-cases dependencies is not easy, because using mocking library is weird thing to do if `widgetbook` is not a dev dependency.
3. CLI is not actively used by users, which makes some features hard to implement.
4. There is no defined structure for **projects**. It can be defined inside the `lib`, `test` or `widgetbook` folders, and each one has it’s pros and cons.
5. There is no defined structure for **use-cases**. Users can do any of the following setups:
   - They can define use-cases in the same file as the widget.
   - They can define all use-cases from different components in one file.
6. Users need to define the `label` for knobs using a magic string that usually is the same name as the parameter name.
7. Generator is slow inside big projects, because all `.dart` files are taken as an input.

## Solution

In Widgetbook 4.0 (where the burgers are finally on _master chef_ level 🍔), we aim to introduce a well thought out structure on how to work and maintain Widgetbook for any size of project featuring poly and mono repo approaches as well as quick-setups to try out Widgetbook.

Some terminologies (along with their code names) will be changed as follow:

1. Use-case → Story
2. Knob → Arg

### Project Structure

Widgetbook projects will now be defined inside a separate package as follows:

```
# Polyrepo
├── lib/
├── test/
├── widgetbook/
│   └── pubspec.yaml # widgetbook_workspace
└── pubspec.yaml # app

# Monorepo
├── apps/
│   ├── app_1/
│   └── app_2/
├── packages/
│   ├── package_1/
│   └── package_2/
└── widgetbook/
    └── pubspec.yaml # widgetbook_workspace

# Unsupported Polyrepo
├── lib/
├── test/
├── widgetbook/ # folder not project, for simplicity
└── pubspec.yaml # app
```

There will be an intentional cyclic dependencies between `widgetbook_workspace` projects and `app` projects because:

1. `widgetbook_workspace` project needs dependency on `app` to catalog the widgets defined there.
2. `app` needs dependency on `widgetbook_workspace` to define the tests inside the `test` folder, re-using the stories defined in the workspace.

### Story Structure

Stories will now be created in a file named `<component>.stories.dart`. This file will contain:

1. Metadata about the Component itself (e.g. name, description, etc.)
2. Stories definitions.

> [!NOTE]
> 💡 The `.stories.dart` file extension makes it easier for the generator to find these files.

Here’s an example of what the users will be writing:

```dart
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
```

```dart
import 'package:user_app/button.dart';
import 'package:widgetbook/widgetbook.dart';

part 'button.stories.g.dart';

const metadata = ComponentMetadata(
  type: Button, // Used to generate the ButtonArgs
  name: 'Primary button', // Defaults to type's name
  description: 'A button to click on.', // Defaults to type's doc comment
);
```

The above code is enough to generate the following:

```dart
part of 'button.stories.dart';

typedef ButtonScenario = WidgetbookScenario<Button>;

class ButtonStory extends WidgetbookStory<Button, ButtonArgs> {
  ButtonStory({
    required super.name,
    super.setup,
    required super.args,
    super.builder,
  });
}

/// A wrapper around the constructor of [Button] that allows to pass
/// [Arg] instead of the constructor arguments.
class ButtonArgs extends WidgetbookArgs<Button> {
  ButtonArgs({
    required Arg<String> text,
    required Arg<Color> color,
  })  : this.text = text.mergeWith(
          name: 'Text',
          description: 'The text of this button.',
        ),
        this.color = color.mergeWith(
          name: 'Color',
          description: 'The background color of this button.',
        );

  final Arg<String> text;
  final Arg<Color> color;

  Widget build(BuildContext context) {
    return Button(
      text: text.value,
      color: color.value,
    );
  }
}
```

Then users can define the story as follows:

```dart
// final metadata = ...

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
```

### Golden Tests Structure

When it comes to widget or golden testing, [OSS Developer](https://www.notion.so/OSS-Developer-bff800fc1e7647a4af8d3165f607083f?pvs=21)s can re-use stories and convert them to scenarios. Since stories define the way a component is build, a story just needs to define the used addons and the default value of the knobs.

```dart
import 'package:alchemist/alchemist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:user_app/button.dart';
import 'package:widgetbook_workspace/button.stories.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  group(
    '$Button Golden Tests',
    () {
      goldenTest(
        'renders correctly',
        fileName: '$Button',
        builder: () => GoldenTestGroup(
          children: [
            ButtonScenario(
              story: defaultButton,
              addons: [],
              args: ButtonArgs(
                color: ColorArg(Colors.black),
                text: StringArg('Short'),
              ),
            ),
            ButtonScenario(
              story: defaultButton,
              addons: [],
              args: ButtonArgs(
                color: ColorArg(Colors.black),
                text: StringArg('Very LongLongLongLongLong Text'),
              ),
            ),
            ButtonScenario.matrix(
                addons: [
                    [DeviceAddon(device: iphoneX), ThemeAddon(dark)],
                    [DeviceAddon(device: iphoneX), ThemeAddon(light)],
                ],
                args: [ButtonArgs(), ButtonArgs(), ButtonArgs()]
            ),
          ],
        ),
      );
    },
  );
}
```

## CLI 4

Widgetbook 4 will be so dependent on the CLI, you can use the CLI to init, run, publish Widgetbook. Here are some commands that we can add:

1. `widgetbook login`: Gets user API key via a login redirect, then stores the values in a global config file.
2. `widgetbook init`: creates new project template. Should prompt the user for things like GitHub Actions and Widgetbook Cloud.
3. `widgetbook run platform`: similar to `flutter run` and will be used for tracking as well.

## VSCode Plugin

We can have a plugin that helps:

1. Navigating between Widget file and Stories file.
2. Creating a template file for a story.

## Tracking

Tracking in Widgetbook 3 was done via the `widgetbook_generator` package. In Widgetbook 4, the CLI will be used more to track users behaviors.

## Consequences

1. `widgetbook_annotation` will no longer be needed.

## Migration Plan

The new features should be introduced in Widgetbook 3 as “experimental” features. In the last minor release of Widgetbook 3, all old code should be deprecated and users should be referenced to use the new code.

All breaking changes will then be done and a new major release will be available.
