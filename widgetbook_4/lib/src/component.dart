import 'arg.dart';
import 'story.dart';

// TODO: check if we need this class
abstract class WidgetbookComponent<T> {
  const WidgetbookComponent({
    required this.metadata,
    required this.stories,
  });

  final ComponentMetadata metadata;
  final List<WidgetbookStory<T, WidgetbookArgs>> stories;
}

class ComponentMetadata {
  const ComponentMetadata({
    required this.type,
    this.name,
    this.description,
    this.designUrl,
    this.documentation,
  });

  final Type type;
  final String? name;
  final String? description;
  final String? designUrl;
  final String? documentation;

  ComponentMetadata mergeWith(ComponentMetadata other) {
    return ComponentMetadata(
      type: type,
      name: other.name ?? name,
      description: other.description ?? description,
      designUrl: other.designUrl ?? designUrl,
      documentation: other.documentation ?? documentation,
    );
  }
}
