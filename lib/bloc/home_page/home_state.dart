import '../../models/news_model.dart';
import '../../utils/resource.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  // final Resource<List<PageModel>> pageResource;
  final Resource<List<News>> newsResource;

  HomeSuccess({required this.newsResource});
}

class HomeNewsDetail extends HomeState {
  final News news;

  HomeNewsDetail({required this.news});
}

class HomeError extends HomeState {}
