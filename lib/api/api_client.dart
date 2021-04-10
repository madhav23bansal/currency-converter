import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiClient {
  final Uri currentUrl = Uri.https(
    "free.currconv.com",
    "/api/v7/currencies",
    {"apiKey": "b49059d7bb192d80b53e"},
  );

  Future<List<String>> getCurrencies() async {
    http.Response res = await http.get(currentUrl);
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      var list = body['results'];
      List<String> currencies = (list.keys).toList();
      return currencies;
    } else {
      throw Exception("Failed to connect to API");
    }
  }

  Future<double> getRate(String from, String to) async {
    final Uri convertUrl = Uri.https(
      "free.currconv.com",
      "/api/v7/convert",
      {
        "apiKey": "b49059d7bb192d80b53e",
        "q": "${from}_$to",
        "compact": "ultra",
      },
    );

    http.Response res = await http.get(convertUrl);
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      return body["${from}_$to"];
    } else {
      throw Exception("Failed to connect to API");
    }
  }
}
