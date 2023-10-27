# Widgetbook 4: A Clean Slate

## Why?

Widgetbook 3 is now facing some issues that result in a bad developer experience or some limitations. These issues are:

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

### Terminology

Some terminologies (along with their code names) will be changed as follows:

| Old Name | New Name |
| -------- | -------- |
| Use-case | Story    |
| Knob     | Arg      |

### Project Structure

Widgetbook projects will now be defined inside a **separate package** as follows:

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

There will be an **intentional cyclic dependency** _(sorry for using the c-word, we know it hurts)_ between `widgetbook_workspace` projects and `app` projects because:

1. `widgetbook_workspace` project needs dependency on `app` to catalog the widgets defined there.
2. `app` needs dependency on `widgetbook_workspace` to define the tests inside the `test` folder, re-using the stories defined in the workspace.

### Story Structure

> [!IMPORTANT]
> Full code can be found in [`button.stories.dart`](./example/widgetbook/lib/button.stories.dart) or [`home_screen.stories.dart`](./example/widgetbook/lib/home_screen.stories.dart).

Stories will now be created in a file named `<component>.stories.dart`. The `.stories.dart` file extension makes it easier for the generator to find these files. This file will contain:

1. Metadata about the Component itself (e.g. name, description, etc.)
2. Stories definitions.

The workflow for cataloging widgets will be as follows:

1. Write the widget as usual in a file named `<component>.dart` inside the **app directory**. Here is an example of a `Button` widget defined in [`button.dart`](./example/lib/button.dart):

   ```dart
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

1. Create a file named [`button.stories.dart`](./example/widgetbook/lib/button.stories.dart) inside the **`widgetbook` directory** with the following content:

   ```dart
   import 'package:user_app/button.dart';
   import 'package:widgetbook/widgetbook.dart';

   part 'button.stories.g.dart';

   const metadata = ComponentMetadata(
     type: Button, // Used to for code generation
     // Optional config here...
   );
   ```

1. After running the generator _(or possibly a Widgetbook CLI command)_, the following content will be generated in [`button.stories.g.dart`](./example/widgetbook/lib/button.stories.g.dart):

   ```dart
   part of 'button.stories.dart';

   typedef ButtonScenario = WidgetbookScenario<Button>;

   class ButtonStory extends WidgetbookStory<Button, ButtonArgs> { ... }

   class ButtonArgs extends WidgetbookArgs<Button> { ... }
   ```

1. They can now define stories in [`button.stories.dart`](./example/widgetbook/lib/button.stories.dart) with the following content using the generated classes

   ```dart
   final $DefaultButton = ButtonStory(
     name: 'Default',
     args: ButtonArgs(
       text: StringArg('Press'),
       color: ColorArg(
         Colors.red,
         name: 'Background Color',
         description: '....',
       ),
     ),
   );
   ```

### Golden Tests Structure

> [!IMPORTANT]
> Full code can be found in [`golden_test.dart`](./example/test/golden_test.dart).

When it comes to widget or golden testing, users can re-use stories and convert them to scenarios. Since stories define the way a component is build, a story just needs to define the used addons and the default value of the args.

1. **Single Scenario:**

   ```dart
   ButtonScenario(
     story: $DefaultButton,
     addons: [],
     args: ButtonArgs(
       color: ColorArg(Colors.black),
       text: StringArg('Very LongLongLongLongLong Text'),
     ),
   ),
   ```

1. **Matrix Scenario:**  
   Generates 4 scenarios in the following case:

   1. Dark Theme + First Args
   2. Dark Theme + Second Args
   3. Light Theme + First Args
   4. Light Theme + Second Args

   ```dart
   ButtonScenario.matrix(
     story: $DefaultButton,
     addons: [
       [
         MaterialThemeAddon(...), // Dark Theme
         MaterialThemeAddon(...), // Light Theme
       ],
     ],
     args: [
       ButtonArgs(...), // First Args
       ButtonArgs(...), // Second Args
     ],
   )
   ```

## CLI 4

Widgetbook 4 will be so dependent on the CLI to make it easier to add features in the future. Here are some commands that we _might_ add:

| Command                     | Description                                                                         |
| --------------------------- | ----------------------------------------------------------------------------------- |
| `widgetbook init`           | Creates a new project template, could prompt for Widgetbook Cloud or GitHub Actions |
| `widgetbook login`          | Gets Widgetbook Cloud API key via a login redirect, and stores it                   |
| `widgetbook run <platform>` | Similar to `flutter run`                                                            |
| `widgetbook gen`            | Similar to `dart run build_runner` to generate the stories files                    |

## VSCode Plugin

We can have a plugin that helps:

1. Navigating between Widget file and Stories file.
2. Creating a template file for a story.

## Consequences

1. `widgetbook_annotation` will no longer be needed.

## Migration Plan

The new features should be introduced in Widgetbook 3 as “experimental” features. In the last minor release of Widgetbook 3, all old code should be deprecated and users should be referenced to use the new code.

All breaking changes will then be done and a new major release will be available.
