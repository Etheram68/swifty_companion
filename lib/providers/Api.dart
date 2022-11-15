import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Api {

  static final Api _instance = Api._internal();
  final String url = "https://api.intra.42.fr";
  final String authUrl = "/oauth/authorize";
  final String tokenUrl = "/oauth/token";
  final String clientId = dotenv.env["API_UID"]!;
  final String clientSecret = dotenv.env["API_SECRET"]!;
  String? token;

  Api._internal();

  factory Api() {
    return _instance;
  }

  void getToken() async {
    Map<String, String> payload = {'grant_type': 'client_credentials', 'response_type': 'code',
        'client_id': clientId, 'client_secret': clientSecret};

    var r = await http.post(Uri.parse(url+tokenUrl), body: payload);
    if (r.statusCode == 200) {
      token = jsonDecode(utf8.decode(r.bodyBytes))["access_token"];
    }
  }

}