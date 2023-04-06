import 'dart:convert';
import 'dart:io';
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

  Future<String?> getToken() async {
    Map<String, String> payload = {'grant_type': 'client_credentials', 'response_type': 'code',
        'client_id': clientId, 'client_secret': clientSecret};

    var r = await http.post(Uri.parse(url+tokenUrl), body: payload);
    if (r.statusCode == 200) {
      token = jsonDecode(utf8.decode(r.bodyBytes))["access_token"];
    }
    return token;
  }

  Future<dynamic> get({required String path, Map<String, String>? params}) async {
    Map<String, String> headers = {'Authorization': 'Bearer $token'};
    var uri = Uri.parse(url+path);
    int counter = 0;

    if (params != null) {
      uri = uri.replace(queryParameters:params);
    }
    while (true) {
      final r = await http.get(uri, headers: headers);
      // Switch for check different code returned by API
      switch (r.statusCode) {

        // 401: Unauthorized Try to create new Token
        case 401: {
          if (counter > 3) {
            throw http.ClientException("Error to create Token, contact support");
          }
          stderr.writeln("Error 401");
          getToken();
          counter += 1;
        }
        break;

        // 429 Limit request send, await and resend request.
        case 429: {
          if (counter > 3) {
            throw http.ClientException("Query limit request");
          }
          stderr.writeln("Error 429 Wait 1 second");
          sleep(const Duration(seconds:1));
          counter += 1;
        }
        break;

        // Return result send on Json object
        default: {
          counter += 0;
          // return jsonDecode(utf8.decode(r.bodyBytes));
        }
      }
    }
  }

}