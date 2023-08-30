part of 'button.stories.dart';

class ButtonStory extends WidgetbookStory<Button, ButtonArgs> {
  ButtonStory({
    required super.name,
    required super.setup,
    required super.args,
    required super.builder,
  });

  ComponentMetadata get component => ComponentMetadata(
        name: '$Button',
        type: Button,
        description: 'A button to click on.', // From doc comment
      ).mergeWith(metadata);
}

class ButtonArgs extends WidgetbookArgs<Button> {
  ButtonArgs({
    required String text,
    required Color color,
  })  : this.text = WidgetbookArg<String>(
          value: text,
          name: 'Text',
          description: 'The text of this button.',
        ),
        this.color = WidgetbookArg<Color>(
          value: color,
          name: 'Color',
          description: 'The background color of this button.',
        );

  final WidgetbookArg<String> text;
  final WidgetbookArg<Color> color;

  Widget build(BuildContext context) {
    return Button(
      text: text.value,
      color: color.value,
    );
  }
}
