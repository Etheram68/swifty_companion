import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'providers/Api.dart';

void main() async {
  await dotenv.load();
  Api provider = Api();
  await provider.getToken();

  // provider.get(path:"/v2/users").then((values) => {
  //   for (var value in values) {
  //     print(value['login'])
  //   }
  // });
  runApp(const Companion());
}

class Companion extends StatelessWidget {
  const Companion({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Companion',
      theme: ThemeData(
        primaryColor: Colors.green,
      ),
      home: const SearchPage(title: 'Companion - Search'),
    );
  }
}

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
