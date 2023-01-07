import 'package:flutter/material.dart';
import 'dart:async';
import '../providers/Api.dart';


class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBar();
}

class _SearchBar extends State<SearchBar> {
  final _delegate = CustomSearchDelegate();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Ink(
        decoration: const ShapeDecoration(
          color: Colors.lightBlue,
          shape: CircleBorder(),
        ),
        child: IconButton(
          icon: const Icon(Icons.search),
          color: Colors.white,
          onPressed: () {
            showSearch(context: context, delegate: _delegate);
          },
        ),
      ),
    );
  }
}


class CustomSearchDelegate  extends SearchDelegate {

  List<String> searchNames = [];
  Timer? timer;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
          searchNames.clear();
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView.builder(
      itemCount: searchNames.length,
      itemBuilder: (context, index) {
        var result = searchNames[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    return FutureBuilder<List<dynamic>?>(
      future: getSuggestLogin(),
      builder: (context, snapshot){
        if (snapshot.data == null) {
          return const Center(child: CircularProgressIndicator(),);
        } else {
          List<dynamic> suggestLogin = snapshot.data!;
          searchNames.clear();
          for (var e in suggestLogin) {
            searchNames.add(e['login']);
          }

          return ListView.builder(
            itemCount: searchNames.length,
            itemBuilder: (context, index) {
              var result = searchNames[index];
              return ListTile(
                title: Text(result),
              );
            },
          );
        }
      }
    );
  }

  Future<List<dynamic>?> getSuggestLogin() async {
    Api provider = Api();
    var result;

    if (query.length > 2) {
      result = await provider.get(path: "/v2/users/",
          params: {"range[login]": "${query.toLowerCase()}, ${query.toLowerCase()}zzzzz"}
      );
    }
    return result;
  }
}