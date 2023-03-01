import 'package:flutter/material.dart';
import 'dart:async';
import '../providers/Api.dart';
import '../screens/Profile.dart';
import '../screens/Search.dart';


class SearchBar extends State<SearchPage> {
  List<String> _suggestions = [];
  late final Api _provider = Api();
  Timer? _debounce;
  late final TextEditingController _textEditingController;
  String _lastSearchString = '';

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Image.asset('img/logo.png'),
                ),
                _buildSearchField(),
                Expanded(
                    child: Scrollbar(
                        thumbVisibility: true,
                        child: ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) => _buildListItem(index),
                            separatorBuilder: (context, index) => const Divider(),
                            itemCount: _suggestions.length
                        )
                    )
                )
              ],
            ),
          ),
        ),
      )
    );
  }

  TextField _buildSearchField() {
    return TextField(
      controller: _textEditingController,
      decoration: const InputDecoration(
          hintText: "Enter a search Login ...",
          border: OutlineInputBorder()
      ),
      onChanged: (value) {
        _suggestions = [];
        if (_debounce?.isActive ?? false) {
          _debounce?.cancel();
        }
        _debounce = Timer(const Duration(milliseconds: 500), () {
          _fetchSuggestions(value.toLowerCase());
        });
      },
      onSubmitted: (value) {
        final nextPage = ProfilePage(login: value);
        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx){
          return nextPage;
        }));
      },
    );
  }

  Widget _buildListItem(int index) {
    final suggestion = _suggestions[index];
    return ListTile(
      title: Text(_suggestions[index]),
      onTap: () {
        _textEditingController.text = suggestion;
      }
    );
  }

  void _fetchSuggestions(String query) async {
    if (query == _lastSearchString) {
      return;
    }
    final response = await _provider.get(path: "/v2/users/",
        params: {"range[login]": "$query, ${query}zzzzz"}
    );
    _suggestions = [for (var e in response) e['login']];
    setState(() {
      _suggestions.retainWhere((element) => element.toLowerCase().contains(query));
    });
    _lastSearchString = query;
  }
}
