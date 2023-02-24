import 'package:flutter/material.dart';
import '../screens/Search.dart';

class Companion extends StatelessWidget {
  const Companion({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Companion',
      theme: ThemeData(
        primaryColor: Colors.green,
      ),
      home: const SearchPage(),
    );
  }
}