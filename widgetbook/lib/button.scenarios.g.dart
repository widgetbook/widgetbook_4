import 'package:fruits_app/button.dart';

import 'button.stories.dart';
import 'widgetbook_4.dart';

// Does this class makes sense? Or we should do buttonStory.toScenario()?
class ButtonScenario extends WidgetbookScenario<Button> {
  ButtonScenario({
    required super.addons,
    required super.knobs,
  }) : super(story: buttonStory);
}
