import '../../constants/constants.dart';
import '../../inheritance/mixin_card_feature.dart';
import '../../utils/generator.dart';
import '../../utils/resource.dart';

class ProfileRepository with MixinCardFeature {
  RestClient client;
  ProfileRepository(this.client);
  Future<Resource<bool>> changePassword(String newPassword) async {
    final restClient = RestClient.create();
    var value = await restClient.changePassword({
      "userId": Constants.USER.userId,
      "newPassword": newPassword,
    });
    if (value.status == Status.SUCCESS) {
      return Resource.success(value.data!);
    } else {
      return Resource.error(value.errorMessage!, value.statusCode);
    }
  }

  Future<Resource<bool>> deleteAccount() async {
    final restClient = RestClient.create();
    var value = await restClient.deleteAccount({
      "userEmail": Constants.USER.userEmail,
    });
    if (value.status == Status.SUCCESS) {
      return Resource.success(value.data!);
    } else {
      return Resource.error(value.errorMessage!, value.statusCode);
    }
  }
}
