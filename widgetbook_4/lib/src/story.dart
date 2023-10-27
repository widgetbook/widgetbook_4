import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart' as v3;

import 'arg.dart';

abstract class WidgetbookStory<T, TArgs extends WidgetbookArgs<T>> {
  WidgetbookStory({
    required this.name,
    required this.args,
    this.setup = _defaultSetup,
    this.builder,
  });

  final String name;
  final TArgs args;
  final Widget Function(BuildContext context, Widget child) setup;
  final Widget Function(BuildContext context, TArgs args)? builder;

  static Widget _defaultSetup(BuildContext context, Widget child) {
    return child;
  }

  Widget build(
    BuildContext context,
    List<v3.WidgetbookAddon> addons,
    TArgs args,
  ) {
    final storyBuilder = builder ?? args.build;

    return Column(
      children: [
        Text('Building with ${addons.length} addons}'),
        setup(
          context,
          storyBuilder(context, args),
        ),
      ],
    );
  }
}
