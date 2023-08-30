import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

class WidgetbookArg<T> {
  const WidgetbookArg({
    required this.value,
    required this.name,
    this.description,
  });

  final T value;
  final String name;

  // From doc comment
  final String? description;

  // EXPERIMENTAL
  // Widgetbook.material{
  //   argsResolver: <T, T Function(WidgetbookArg<T>)>{
  //   String: (arg) => StringKnob(arg.name...),
  //   Double: ???
  //   FooVar: (WidgetbookArg<FooVar> arg) =>
  // }}
  // T toKnob() {
  //  final resolver = argsResolver[T];
  //  return resolver(this);
  // }
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
  final List<WidgetbookStory<T, WidgetbookArgs<T>>> stories;
}

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
  final Widget Function(BuildContext context, TArgs args) builder;

  ComponentMetadata get component;

  Widget build(
    BuildContext context,
    List<WidgetbookAddon> addons,
    TArgs args,
  ) {
    return Column(
      children: [
        Text('Building with ${addons.length} addons}'),
        builder(context, args),
      ],
    );
  }

  WidgetbookScenario<T> toScenario({
    required List<WidgetbookAddon> addons,
    required WidgetbookArgs<T> args,
  }) {
    return WidgetbookScenario<T>(
      story: this,
      addons: addons,
      args: args,
    );
  }
}

abstract class WidgetbookArgs<T> {
  Widget build(BuildContext context);
}

class WidgetbookScenario<T> {
  const WidgetbookScenario({
    required this.story,
    required this.addons,
    required this.args,
  });

  final WidgetbookStory<T, WidgetbookArgs<T>> story;
  final List<WidgetbookAddon> addons;
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
