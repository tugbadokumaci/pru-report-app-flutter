import 'package:qr_code_app/models/eu_project_model.dart';
import 'package:qr_code_app/service_locator.dart';

import '../../utils/generator.dart';
import '../../utils/resource.dart';

class ProjectsRepository {
  RestClient client = locator<RestClient>();

  ProjectsRepository(RestClient restClient);

  Future<Resource<List<EUProjectModel>>> getAllProjects() async {
    final restClient = RestClient.create();
    var value = await restClient.getAllProjects();
    if (value.status == Status.SUCCESS) {
      return Resource.success(value.data!);
    } else {
      return Resource.error(value.errorMessage!, value.statusCode);
    }
  }
}
