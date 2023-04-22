import 'dart:convert';

import 'package:news_app_flutter/services/rest_api_services.dart';
import 'package:news_app_flutter/source/news/model/news_response_model.dart';

class NewsRepository {
  RestAPIService restAPIService = RestAPIService();

  Future<NewsResponseModel> getNewsResponse(String? searchParam) async {
    var headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    var response = await restAPIService.getRequest(searchParam, headers);
    return NewsResponseModel.fromJson(jsonDecode(response));
  }
}
