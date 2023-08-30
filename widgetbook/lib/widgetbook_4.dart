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
    required this.name,
    required this.setup,
    required this.knobs,
    required this.builder,
  });

  final String name;
  final VoidCallback setup;
  final TKnobs knobs;
  final Widget Function(BuildContext context, TKnobs knobs) builder;

  ComponentMetadata get component;

  Widget build(
    BuildContext context,
    List<WidgetbookAddon> addons,
    TKnobs knobs,
  ) {
    return Column(
      children: [
        Text('Building with ${addons.length} addons}'),
        builder(context, knobs),
      ],
    );
  }
}

// TODO: Resolve name confusion as this are args and not knobs.
abstract class WidgetbookKnobs<T> {}

abstract class WidgetbookScenario<T> {
  const WidgetbookScenario({
    required this.story,
    required this.addons,
    required this.knobs,
  });

  final WidgetbookStory<T, WidgetbookKnobs<T>> story;
  final List<WidgetbookAddon> addons;

  // TODO: Resolve confusion betweeen these knobs and [story.knobs].
  final WidgetbookKnobs<T> knobs;

  Widget build(BuildContext context) {
    return story.build(context, addons, knobs);
  }
}
