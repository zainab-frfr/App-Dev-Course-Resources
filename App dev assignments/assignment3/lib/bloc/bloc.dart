import 'dart:convert';

import 'package:assignment3/data/news_model.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

part 'states.dart';
part 'events.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState>{
  NewsBloc():super(LoadingState()){
    on<FetchNews>(onFetchNews);
  }

  Future<void> onFetchNews(FetchNews fetchNews, Emitter<NewsState> emit) async{
    emit(LoadingState());
    try {
      List<News> allNews = await getNews(); 
      emit(FetchedNews(allNews: allNews));
    } catch (e) {
      emit(ErrorState(errorMessage: e.toString()));
    }
  }

  Future<List<News>> getNews() async {
  List<News> news = [];

  Response apiResponse =
      await http.get(Uri.parse('https://newsapi.org/v2/everything?q=tesla&from=2024-10-16&sortBy=publishedAt&apiKey=abb021fcd9124fe4a756d19365dc0136'));

  if (apiResponse.statusCode == 200) {
    Map<String, dynamic> decoded = jsonDecode(apiResponse.body);
    List jsonNews = decoded['articles'];

    news =
        jsonNews.map((news) => News.fromJson(news)).toList();
  } else {
    news = [];
  }

  return news;
}

}