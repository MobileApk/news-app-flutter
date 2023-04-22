import 'dart:developer';

import 'package:http/http.dart' as http;

class RestAPIService {
  String get getBaseUrl =>
      "https://inshorts.deta.dev/news?category=";

  Future<dynamic> getRequest([String? searchItem, dynamic headers]) async {
    try {
      final request = http.Client();
      String requestUrl = getBaseUrl + (searchItem ?? "");
      log(requestUrl, name: "Request Url");
      var response = await request.get(
        Uri.parse(requestUrl),
        headers: headers,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        log(response.statusCode.toString(), name: "Status Code");
        log(response.body.toString(), name: "Response Data");
      }
    } catch (e) {
      log(e.toString(), name: "Error in Network Service");
    }
  }
}
