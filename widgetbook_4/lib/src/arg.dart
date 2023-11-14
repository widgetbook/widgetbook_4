import 'package:flutter/widgets.dart';

abstract class WidgetbookArgs<T> {
  const WidgetbookArgs();

  /// Maps the args to a widget by passing them to the constructor as-is.
  Widget build(BuildContext context);
}

abstract class Arg<T> {
  final T value;
  final String? name;
  final String? description;

  const Arg(
    this.value, {
    required this.name,
    required this.description,
  });

  Arg<T> mergeWith({
    String? name,
    String? description,
  }) {
    throw UnimplementedError();
  }
}

// TODO: Support custom args
// class CustomArg extends Arg {}

class ColorArg extends Arg<Color> {
  const ColorArg(
    super.value, {
    super.name,
    super.description,
  });
}

class StringArg extends Arg<String> {
  const StringArg(
    super.value, {
    super.name,
    super.description,
  });
}
