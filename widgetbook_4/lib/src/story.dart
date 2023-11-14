import 'package:flutter/widgets.dart';
import 'package:widgetbook_4/src/mode.dart';

import 'arg.dart';

abstract class WidgetbookStory<T, TArgs extends WidgetbookArgs<T>> {
  WidgetbookStory({
    required this.name,
    required this.args,
    this.designUrl,
    this.setup = _defaultSetup,
    this.builder,
  });

  final String name;
  final TArgs args;
  final String? designUrl;
  final Widget Function(BuildContext context, Widget child) setup;
  final Widget Function(BuildContext context, TArgs args)? builder;

  static Widget _defaultSetup(BuildContext context, Widget child) {
    return child;
  }

  Widget build(
    BuildContext context,
    List<WidgetbookMode> modes,
    TArgs args,
  ) {
    final storyBuilder = builder ?? args.build;

    return Column(
      children: [
        Text('Building with ${modes.length} modes'),
        setup(
          context,
          storyBuilder(context, args),
        ),
      ],
    );
  }
}
