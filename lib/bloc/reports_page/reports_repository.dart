import 'package:qr_code_app/utils/generator.dart';

import '../../models/report_model.dart';
import '../../utils/resource.dart';

class ReportsRepository {
  RestClient client;
  ReportsRepository(this.client);

  Future<Resource<List<ReportModel>>> getAllReports() async {
    final restClient = RestClient.create();
    var value = await restClient.getAllReports();
    if (value.status == Status.SUCCESS) {
      return Resource.success(value.data!);
    } else {
      return Resource.error(value.errorMessage!, value.statusCode);
    }
  }
}
