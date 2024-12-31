import 'package:qr_code_app/utils/generator.dart';
import '../../models/post_model.dart';
import '../../utils/resource.dart';

class ReportsRepository {
  RestClient client;
  ReportsRepository(this.client);

  Future<Resource<List<PostModel>>> getAllPosts() async {
    final restClient = RestClient.create();
    var value = await restClient.getAllPosts();
    if (value.status == Status.SUCCESS) {
      return Resource.success(value.data!);
    } else {
      return Resource.error(value.errorMessage!, value.statusCode);
    }
  }
}
