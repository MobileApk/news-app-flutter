import 'dart:developer';

import 'package:http/http.dart' as http;

class RestAPIService {
  String get getBaseUrl =>
      "https://inshorts.deta.dev/news?category=";

  Future<dynamic> getRequest([String? searchItem, dynamic headers]) async {
    try {
      final request = http.Client();
      ResponseData responseData = ResponseData();
      String requestUrl = getBaseUrl + (searchItem ?? "");
      log(requestUrl, name: "Request Url");
      final response = await request.get(
        Uri.parse(requestUrl),
        headers: headers,
      );
      responseData.data = response.body;
      if (responseData.statusCode == 200) {
        return responseData;
      } else {
        log(response.statusCode.toString(), name: "Status Code");
        log(response.body.toString(), name: "Response Data");
      }
    } catch (e) {
      log(e.toString(), name: "Error in Network Service");
    }
  }
}

class ResponseData {
  dynamic data;
  int? statusCode;
  ResponseData({
    this.data,
    this.statusCode,
  });
}
