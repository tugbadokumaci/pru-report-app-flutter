import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_app/bloc/reports_page/reports_cubit.dart';
import 'package:qr_code_app/models/report_model.dart';

import 'reports_state.dart';

class ReportsView extends StatefulWidget {
  final ReportsCubit viewModel;
  ReportsView({Key? key, required this.viewModel}) : super(key: key);

  @override
  State<ReportsView> createState() => _ReportsViewState();
}

class _ReportsViewState extends State<ReportsView> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.getAllReports();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reports'),
      ),
      body: BlocBuilder<ReportsCubit, ReportsState>(
        bloc: widget.viewModel,
        builder: (context, state) {
          if (state is ReportsLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ReportsSuccess) {
            return ListView.builder(
              itemCount: state.reportResource.data!.length,
              itemBuilder: (context, index) {
                ReportModel report = state.reportResource.data![index];
                return ListTile(
                  title: Text(report.reportTitle),
                  subtitle: Text(report.reportDescription),
                  onTap: () {
                    // Navigate to report details page or perform any other action
                  },
                );
              },
            );
          } else if (state is ReportsError) {
            return Center(
              child: Text('Error fetching reports'),
            );
          } else {
            return Center(
              child: Text('Unknown state'),
            );
          }
        },
      ),
    );
  }
}
