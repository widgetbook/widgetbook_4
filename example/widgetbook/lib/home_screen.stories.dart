import 'package:flutter/material.dart';
import 'package:fruits_app/home_screen.dart';
import 'package:fruits_app/user_provider.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook_4/widgetbook_4.dart';

part 'home_screen.stories.g.dart';

const metadata = ComponentMetadata(
  type: HomeScreen,
);

final $DefaultHomeScreen = HomeScreenStory(
  name: 'Default',
  setup: (context, child) {
    // Since HomeScreen needs UserProvider,
    // some mocking is needed to be able to provide it.
    return ChangeNotifierProvider<UserProvider>(
      create: (_) => FakeUserProvider(),
      child: child,
    );
  },
);

class FakeUserProvider extends Fake implements UserProvider {
  @override
  User get user => User('Fake User');
}
