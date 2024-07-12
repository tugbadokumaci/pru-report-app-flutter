import '../../models/report_model.dart';
import '../../utils/resource.dart';

abstract class ReportsState {}

class ReportsInitial extends ReportsState {}

class ReportsLoading extends ReportsState {}

class ReportsSuccess extends ReportsState {
  final Resource<List<ReportModel>> reportResource;

  ReportsSuccess({required this.reportResource});
}

class ReportsDetail extends ReportsState {
  final ReportModel report;

  ReportsDetail({required this.report});
}

class ReportsError extends ReportsState {}
