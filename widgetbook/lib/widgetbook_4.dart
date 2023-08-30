import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

class ComponentMetadata {
  const ComponentMetadata({
    required this.name,
    required this.type,
    required this.description,
  });

  final String name;
  final Type type;
  final String description;
}

abstract class WidgetbookComponent<T> {
  const WidgetbookComponent({
    required this.metadata,
    required this.stories,
  });

  final ComponentMetadata metadata;
  final List<WidgetbookStory<T>> stories;
}

class WidgetbookStory<T> {
  WidgetbookStory({
    required this.setup,
    required this.knobs,
    required this.builder,
  });

  final VoidCallback setup;
  final WidgetbookKnobs<T> knobs;
  final Widget Function(BuildContext context, WidgetbookKnobs<T> knobs) builder;

  Widget build(BuildContext context, List<WidgetbookAddon> addons) {
    return Column(
      children: [
        Text('Building with ${addons.length} addons}'),
        builder(context, knobs),
      ],
    );
  }
}

abstract class WidgetbookKnobs<T> {}
