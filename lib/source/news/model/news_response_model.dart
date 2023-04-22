class NewsResponseModel {
  String? category;
  List<NewsData>? newsDataList;
  bool? success;

  NewsResponseModel({this.category, this.newsDataList, this.success});

  NewsResponseModel.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    if (json['data'] != null) {
      newsDataList = <NewsData>[];
      json['data'].forEach((v) {
        newsDataList!.add(NewsData.fromJson(v));
      });
    }
    success = json['success'];
  }
}

class NewsData {
  String? author;
  String? content;
  String? date;
  String? id;
  String? imageUrl;
  String? readMoreUrl;
  String? time;
  String? title;
  String? url;

  NewsData(
      {this.author,
      this.content,
      this.date,
      this.id,
      this.imageUrl,
      this.readMoreUrl,
      this.time,
      this.title,
      this.url});

  NewsData.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    content = json['content'];
    date = json['date'];
    id = json['id'];
    imageUrl = json['imageUrl'];
    readMoreUrl = json['readMoreUrl'];
    time = json['time'];
    title = json['title'];
    url = json['url'];
  }
}
