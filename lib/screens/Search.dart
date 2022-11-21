import 'package:flutter/material.dart';
import '../widgets/SearchBar.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: const SearchBar()
    );
  }
}