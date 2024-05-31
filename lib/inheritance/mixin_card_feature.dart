import '../constants/constants.dart';
import '../models/card_model.dart';
import '../models/user_model.dart';
import '../service_locator.dart';
import '../utils/generator.dart';
import '../utils/resource.dart';

mixin MixinCardFeature {
  RestClient client = locator<RestClient>();

  Future<Resource<List<CardModel>>> getCards() async {
    final restClient = RestClient.create();
    var value = await restClient.getCards({"userId": "1"});
    Duration(seconds: 10);
    if (value.status == Status.SUCCESS) {
      return Resource.success(value.data!);
    } else {
      return Resource.error(value.errorMessage!, value.statusCode);
    }
  }

  Future<Resource<List<CardModel>>> getSavedCards() async {
    final restClient = RestClient.create();
    var value = await restClient.getSavedCards({"userId": "1"});
    if (value.status == Status.SUCCESS) {
      return Resource.success(value.data!);
    } else {
      return Resource.error(value.errorMessage!, value.statusCode);
    }
  }

  Future<Resource<UserModel>> login(String email, String password) async {
    final restClient = RestClient.create();
    Resource<UserModel> value = await restClient.login({"userEmail": email, "userPassword": password});
    if (value.status == Status.SUCCESS) {
      Constants.USER = value.data!;
      return Resource.success(value.data!);
    } else {
      return Resource.error(value.errorMessage!, value.statusCode);
    }
  }
  // Future<Resource<List<UserModel>>> fetchData() async {
  //   try {
  //     final restClient = RestClient.create();
  //     List<UserModel> value = await restClient.fetchData();
  //     return Resource.success(value);
  //   } catch (e) {
  //     return Resource.error('Failed to fetch datas: $e');
  //   }
  // }
}
