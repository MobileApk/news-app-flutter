part of 'news_cubit.dart';

class NewsState {
  final List<NewsData>? listOfNewsData;
  final Status? status;
  final String? selectedCategory;
  final String? titleSearch;
  final String? errorMessage;
  String? dropdownValue = "all";

  NewsState({
    this.listOfNewsData,
    this.status,
    this.selectedCategory,
    this.titleSearch,
    this.errorMessage,
    this.dropdownValue,
  });

  NewsState copyWith({
    List<NewsData>? listOfNewsData,
    Status? status,
    String? selectedCategory,
    String? titleSearch,
    String? errorMessage,
    String? dropdownValue,
  }) {
    return NewsState(
      listOfNewsData: listOfNewsData ?? this.listOfNewsData,
      status: status ?? this.status,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      titleSearch: titleSearch ?? this.titleSearch,
      errorMessage: errorMessage ?? this.errorMessage,
      dropdownValue: dropdownValue ?? this.dropdownValue,
    );
  }
}
