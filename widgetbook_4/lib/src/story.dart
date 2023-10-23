import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart' as v3;

import 'arg.dart';

abstract class WidgetbookStory<T, TArgs extends WidgetbookArgs<T>> {
  WidgetbookStory({
    required this.name,
    required this.setup,
    required this.args,
    required this.builder,
  });

  final String name;
  final VoidCallback setup;
  final TArgs args;
  final Widget Function(BuildContext context, TArgs args)? builder;

  Widget build(
    BuildContext context,
    List<v3.WidgetbookAddon> addons,
    TArgs args,
  ) {
    return Column(
      children: [
        Text('Building with ${addons.length} addons}'),
        if (builder != null) ...{
          builder!(context, args),
        } else ...{
          args.build(context),
        }
      ],
    );
  }
}
