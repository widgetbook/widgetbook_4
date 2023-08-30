import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

class ArgMetadata {
  const ArgMetadata({
    required this.name,
    required this.description,
  });

  final String name;
  final String? description;
}

class ComponentMetadata {
  const ComponentMetadata({
    required this.type,
    required this.name,
    required this.description,
  });

  final Type type;
  final String? name;
  final String? description;

  ComponentMetadata mergeWith(ComponentMetadata other) {
    return ComponentMetadata(
      type: type,
      name: other.name ?? name,
      description: other.description ?? description,
    );
  }
}

abstract class WidgetbookComponent<T> {
  const WidgetbookComponent({
    required this.metadata,
    required this.stories,
  });

  final ComponentMetadata metadata;
  final List<WidgetbookStory<T, WidgetbookKnobs<T>>> stories;
}

abstract class WidgetbookStory<T, TKnobs extends WidgetbookKnobs<T>> {
  WidgetbookStory({
    required this.setup,
    required this.knobs,
    required this.builder,
  });

  final VoidCallback setup;
  final TKnobs knobs;
  final Widget Function(BuildContext context, TKnobs knobs) builder;

  ComponentMetadata get component;

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
