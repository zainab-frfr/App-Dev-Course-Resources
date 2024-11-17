part of 'bloc.dart';

sealed class NewsState{}

final class LoadingState extends NewsState{}

final class FetchedNews extends NewsState{
  final List<News> allNews;
  FetchedNews({required this.allNews});
}
final class ErrorState extends NewsState{
  final String errorMessage;
  ErrorState({required this.errorMessage});
}