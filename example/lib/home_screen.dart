import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'user_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UserProvider>(
        builder: (_, provider, __) {
          return Center(
            child: Text('Hello ${provider.user.name}!'),
          );
        },
      ),
    );
  }
}
