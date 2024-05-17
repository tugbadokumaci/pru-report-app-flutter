import '../../inheritance/mixin_card_feature.dart';
import '../../utils/generator.dart';

class HomeRepository with MixinCardFeature {
  RestClient client;
  HomeRepository(this.client);
}
