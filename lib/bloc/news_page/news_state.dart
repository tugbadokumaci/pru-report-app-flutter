import '../../models/news_model.dart';
import '../../utils/resource.dart';

abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsSuccess extends NewsState {
  final Resource<List<News>> newsResource;

  NewsSuccess({required this.newsResource});
}

class NewsDetail extends NewsState {
  final News news;

  NewsDetail({required this.news});
}

class NewsError extends NewsState {}
