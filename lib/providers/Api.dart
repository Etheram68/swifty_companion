import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {

  final String url = "https://api.intra.42.fr";
  final String authUrl = "/oauth/authorize";
  final String tokenUrl = "/oauth/token";
  String clientId;
  String clientSecret;
  String? token;

  Api(this.clientId, this.clientSecret);

  void getToken() async {
    Map<String, String> payload = {'grant_type': 'client_credentials', 'response_type': 'code',
        'client_id': clientId, 'client_secret': clientSecret};

    var r = await http.post(Uri.parse(url+tokenUrl), body: payload);
    if (r.statusCode == 200) {
      var decodedResponse = jsonDecode(utf8.decode(r.bodyBytes)) as Map;
      token = decodedResponse["access_token"];
      print("Value returned ${decodedResponse}");
    }
  }
}