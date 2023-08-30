import 'package:widgetbook_fruits_app/button.stories.dart';
import 'package:widgetbook_fruits_app/widgetbook_4.dart';
import 'package:fruits_app/button.dart';

// Does this class makes sense? Or we should do buttonStory.toScenario()?
class ButtonScenario extends WidgetbookScenario<Button> {
  ButtonScenario({
    required super.addons,
    required super.knobs,
  }) : super(story: buttonStory);
}
