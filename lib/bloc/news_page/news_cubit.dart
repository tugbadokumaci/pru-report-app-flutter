import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_app/bloc/news_page/news_repository.dart';

import '../../models/news_model.dart';
import '../../utils/resource.dart';
import 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final NewsRepository _repo;

  late Resource<List<News>> newsResource;

  NewsCubit({
    required NewsRepository repo,
  })  : _repo = repo,
        super(NewsInitial());

  Future<void> getAllNews() async {
    emit(NewsLoading());
    newsResource = await _repo.getAllNews();
    if (newsResource.status == Status.SUCCESS) {
      emit(NewsSuccess(newsResource: newsResource));
      debugPrint('get news success');
    } else {
      debugPrint('Error while fetching get news data');
      emit(NewsError());
    }
  }

  void showNewsDetail(News news) {
    emit(NewsDetail(news: news));
  }
}
