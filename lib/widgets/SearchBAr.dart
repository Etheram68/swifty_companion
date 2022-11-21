import 'package:flutter/material.dart';
import '../providers/Api.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    Api provider = Api();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            onSubmitted: (String value) async {
              await provider.get(path:"/v2/users/$value").then((values) => {
                print(values)
              });
            },
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Search'
            ),
          ),
        ),
      ],
    );
  }
}