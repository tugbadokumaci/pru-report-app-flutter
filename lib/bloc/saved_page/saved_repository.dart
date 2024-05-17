import '../../models/card_model.dart';
import '../../utils/generator.dart';
import '../../utils/resource.dart';

class SavedRepository {
  RestClient client;
  SavedRepository(this.client);

  // Future<Resource<List<CardModel>>> getServices() async {
  //   final restClient = RestClient.create();
  //   var value = await restClient.getServices({"userId": Constants.USER.userId});
  //   if (value.status == Status.SUCCESS) {
  //     return Resource.success(value.data!);
  //   } else {
  //     return Resource.error(value.errorMessage!, value.statusCode);
  //   }
  // }

  Future<Resource<List<CardModel>>> getSavedCards() async {
    final restClient = RestClient.create();
    var value = await restClient.getSavedCards({"userId": "1"});
    if (value.status == Status.SUCCESS) {
      return Resource.success(value.data!);
    } else {
      return Resource.error(value.errorMessage!, value.statusCode);
    }
    // return Resource.success(value.data?);
  }
}
