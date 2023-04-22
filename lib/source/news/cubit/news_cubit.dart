import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_flutter/services/repository/news_repo.dart';
import 'package:news_app_flutter/source/news/model/news_response_model.dart';
import 'package:news_app_flutter/source/utils/app_helper.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsState());

  final NewsRepository newsRepository = NewsRepository();

  getNewsResponse() async {
    try {
      emit(state.copyWith(status: Status.loading));
      NewsResponseModel newsResponse =
          await newsRepository.getNewsResponse(state.selectedCategory);
      emit(state.copyWith(
          status: Status.loaded, listOfNewsData: newsResponse.newsDataList));
    } catch (e) {
      log("$e", name: "Error while fetching data in News Cubit");
      emit(state.copyWith(status: Status.error, errorMessage: "$e"));
      emit(state.copyWith(status: Status.loaded));
    }
  }

  void titleSearch(String? searchTerm) {
    emit(state.copyWith(titleSearch: searchTerm));
    if (searchTerm != null) {
      searchItemFromList();
    }
  }

  void searchItemFromList() {
    emit(state.copyWith(status: Status.loading));
    if (state.titleSearch!.isNotEmpty) {
      List<NewsData> filteredNewsList = state.listOfNewsData!
          .where((element) =>
              element.title!.contains(state.titleSearch.toString()))
          .toList();
      emit(state.copyWith(
          status: Status.loaded, listOfNewsData: filteredNewsList));
    } else {
      getNewsResponse();
    }
  }

  void categoryChange(String? value) {
    emit(state.copyWith(selectedCategory: value));
    getNewsResponse();
  }
}
