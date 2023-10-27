import 'package:flutter/material.dart';

/// Similar to [WidgetbookAddon] from Widgetbook v3
abstract class WidgetbookMode {
  final String name;

  const WidgetbookMode({
    required this.name,
  });
}

class ThemeMode extends WidgetbookMode {
  const ThemeMode({
    required this.themes,
  }) : super(name: 'Theme');

  /// Used for golden tests
  ThemeMode.value(ThemeData theme)
      : themes = [theme],
        super(name: 'Theme');

  final List<ThemeData> themes;
}
