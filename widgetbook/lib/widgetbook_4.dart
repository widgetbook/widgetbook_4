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
  final List<WidgetbookStory<T, WidgetbookKnobs<T>>> stories;
}

class WidgetbookStory<TComponent, TKnobs extends WidgetbookKnobs<TComponent>> {
  WidgetbookStory({
    required this.setup,
    required this.knobs,
    required this.builder,
  });

  final VoidCallback setup;
  final TKnobs knobs;
  final Widget Function(
    BuildContext context,
    TKnobs knobs,
  ) builder;

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
