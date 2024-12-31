import '../../models/news_model.dart';
import '../../utils/resource.dart';

abstract class MediaState {}

class MediaInitial extends MediaState {}

class MediaLoading extends MediaState {}

class MediaSuccess extends MediaState {
  final Resource<List<News>> newsResource;

  MediaSuccess({required this.newsResource});
}

class MediaDetail extends MediaState {
  final News news;

  MediaDetail({required this.news});
}

class MediaError extends MediaState {}
