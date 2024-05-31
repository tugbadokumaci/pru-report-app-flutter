import '../../models/report_model.dart';
import '../../utils/resource.dart';

abstract class ReportsState {}

class ReportsInitial extends ReportsState {}

class ReportsLoading extends ReportsState {}

class ReportsSuccess extends ReportsState {
  final Resource<List<ReportModel>> reportResource;

  ReportsSuccess({required this.reportResource});
}

class ReportsError extends ReportsState {}
