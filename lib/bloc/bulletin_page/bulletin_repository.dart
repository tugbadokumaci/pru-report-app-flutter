import '../../models/bulletin_model.dart';
import '../../service_locator.dart';
import '../../utils/generator.dart';
import '../../utils/resource.dart';

class BulletinRepository {
  RestClient client = locator<RestClient>();
  BulletinRepository(this.client);

  Future<Resource<List<Bulletin>>> getAllBulletin() async {
    final restClient = RestClient.create();
    var value = await restClient.getAllBulletin();
    const Duration(seconds: 10);
    if (value.status == Status.SUCCESS) {
      return Resource.success(value.data!);
    } else {
      return Resource.error(value.errorMessage!, value.statusCode);
    }
  }
}
