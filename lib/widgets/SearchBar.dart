import 'package:flutter/material.dart';
import 'dart:async';
import '../providers/Api.dart';


class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBar();
}


class _SearchBar extends State<SearchBar> {
  List<String> _suggestions = [];
  final Api _provider = Api();
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: "Enter a search Login ...",
                border: OutlineInputBorder()
              ),
              onChanged: (value) {
                if (_debounce?.isActive ?? false) {
                  _debounce?.cancel();
                }
                _debounce = Timer(const Duration(milliseconds: 500), () {
                  _fetchSuggestions(value);
                });
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _suggestions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_suggestions[index]),
                    onTap: () {
                      //Action a faire lorsque je selectionne le nom
                      print(_suggestions[index]);
                    }
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void _fetchSuggestions(String query) async {
    _suggestions.clear();
    final response = await _provider.get(path: "/v2/users/",
        params: {"range[login]": "${query.toLowerCase()}, ${query.toLowerCase()}zzzzz"}
    );
    _suggestions = [for (var e in response) e['login']];
    setState(() {
      _suggestions.retainWhere((element) => element.toLowerCase().contains(query.toLowerCase()));
    });
  }
}
