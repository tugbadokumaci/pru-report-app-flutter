import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_app/bloc/reports_page/reports_repository.dart';
import 'package:qr_code_app/models/report_model.dart';

import '../../utils/resource.dart';
import 'reports_state.dart';

class ReportsCubit extends Cubit<ReportsState> {
  final ReportsRepository _repo;

  late Resource<List<ReportModel>> allReportsResource;
  ReportsCubit({
    required ReportsRepository repo,
  })  : _repo = repo,
        super(ReportsInitial());

  Future<void> getAllReports() async {
    emit(ReportsLoading());

    allReportsResource = await _repo.getAllReports();
    if (allReportsResource.status == Status.SUCCESS) {
      emit(ReportsSuccess(reportResource: allReportsResource));
      debugPrint('get services success');
    } else {
      debugPrint('Error while fetching service data');
      emit(ReportsError());
    }
  }

  Future<void> goToDetail(ReportModel report) async {
    emit(ReportsDetail(report: report));
  }
}
