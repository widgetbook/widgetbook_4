part of 'button.stories.dart';

class ButtonStory extends WidgetbookStory<Button, ButtonKnobs> {
  ButtonStory({
    required super.setup,
    required super.knobs,
    required super.builder,
  });

  ComponentMetadata get component => ComponentMetadata(
        name: '$Button',
        type: Button,
        description: 'A button to click on.', // From doc comment
      ).mergeWith(metadata);
}

class ButtonKnobs extends WidgetbookKnobs<Button> {
  ButtonKnobs({
    required this.text,
    required this.color,
  });

  final String text;
  final Color color;

  final ArgMetadata textMetadata = ArgMetadata(
    name: 'Text',
    description: 'The text of this button.', // From doc comment
  );

  final ArgMetadata colorMetadata = ArgMetadata(
    name: 'Color',
    description: 'The background color of this button.', // From doc comment
  );

  Widget build(BuildContext context) {
    return Button(
      text: text,
      color: color,
    );
  }
}
