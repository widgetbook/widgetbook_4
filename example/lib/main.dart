import 'package:flutter/material.dart';
import 'package:fruits_app/home_screen.dart';
import 'package:fruits_app/user_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const FruitsApp());
}

class FruitsApp extends StatelessWidget {
  const FruitsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<UserProvider>(
        create: (_) => UserProvider(),
        child: HomeScreen(),
      ),
    );
  }
}
