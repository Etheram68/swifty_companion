import 'package:http/http.dart' as http;

class Api {

  final String url = "https://api.intra.42.fr";
  final String authUrl = "/oauth/authorize";
  final String tokenUrl = "/oauth/token";
  String clientId;
  String clientSecret;

  Api(this.clientId, this.clientSecret);

  void getToken() async {
    Map<String, String> payload = {'grant_type': 'client_credentials', 'response_type': 'code'};
    var r = await http.get(Uri.parse(url), headers: payload);
    print(r);
  }
}