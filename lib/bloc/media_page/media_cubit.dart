import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/news_model.dart';
import '../../utils/resource.dart';
import 'media_repository.dart';
import 'media_state.dart';

class MediaCubit extends Cubit<MediaState> {
  final MediaRepository _repo;

  late Resource<List<News>> newsResource;

  MediaCubit({
    required MediaRepository repo,
  })  : _repo = repo,
        super(MediaInitial());

  Future<void> getAllNews() async {
    emit(MediaLoading());
    newsResource = await _repo.getAllNews();
    if (newsResource.status == Status.SUCCESS) {
      emit(MediaSuccess(newsResource: newsResource));
      debugPrint('get news success');
    } else {
      debugPrint('Error while fetching get news data');
      emit(MediaError());
    }
  }

  void showNewsDetail(News news) {
    emit(MediaDetail(news: news));
  }
}
