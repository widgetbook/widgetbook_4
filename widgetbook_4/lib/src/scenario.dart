import 'package:flutter/widgets.dart';

import 'arg.dart';
import 'mode.dart';
import 'story.dart';

class WidgetbookScenario<T> {
  const WidgetbookScenario({
    required this.story,
    this.modes,
    this.args,
  });

  static List<WidgetbookScenario<T>> matrix<T>({
    required WidgetbookStory<T, WidgetbookArgs<T>> story,
    List<List<WidgetbookMode>>? modes,
    required List<WidgetbookArgs<T>> args,
  }) {
    // Should permutate addons and args
    return [];
  }

  final WidgetbookStory<T, WidgetbookArgs<T>> story;
  final List<WidgetbookMode>? modes;
  final WidgetbookArgs<T>? args;

  Widget build(BuildContext context) {
    final effectiveArgs = args ?? story.args;

    return Column(
      children: [
        Text('WidgetbookScope'),
        Text('WidgetbookState'),
        Text('Building with ${modes?.length} modes}'),
        effectiveArgs.build(context),
      ],
    );
  }
}
