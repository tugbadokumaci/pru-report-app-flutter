import '../../models/post_model.dart';
import '../../utils/resource.dart';

abstract class ReportsState {}

class ReportsInitial extends ReportsState {}

class ReportsLoading extends ReportsState {}

class ReportsSuccess extends ReportsState {
  final Resource<List<PostModel>> reportResource;

  ReportsSuccess({required this.reportResource});
}

class ReportsDetail extends ReportsState {
  final PostModel post;

  ReportsDetail({required this.post});
}

class ReportsError extends ReportsState {}
