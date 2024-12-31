import '../../models/bulletin_model.dart';
import '../../models/news_model.dart';
import '../../utils/resource.dart';

abstract class BulletinState {}

class BulletinInitial extends BulletinState {}

class BulletinLoading extends BulletinState {}

class BulletinSuccess extends BulletinState {
  // final Resource<List<PageModel>> pageResource;
  final Resource<List<Bulletin>> bulletinResource;

  BulletinSuccess({required this.bulletinResource});
}

class BulletinDetail extends BulletinState {
  final News news;

  BulletinDetail({required this.news});
}

class BulletinError extends BulletinState {
  final String message;

  BulletinError({required this.message});
}
