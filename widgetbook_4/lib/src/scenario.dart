import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart' as v3;

import 'arg.dart';
import 'story.dart';

class WidgetbookScenario<T> {
  const WidgetbookScenario({
    required this.story,
    required this.addons,
    required this.args,
  });

  final WidgetbookStory<T, WidgetbookArgs<T>> story;
  final List<v3.WidgetbookAddon> addons;
  final WidgetbookArgs<T> args;

  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('WidgetbookScope'),
        Text('WidgetbookState'),
        Text('Building with ${addons.length} addons}'),
        args.build(context),
      ],
    );
  }
}
