import '../../inheritance/mixin_card_feature.dart';
import '../../utils/generator.dart';

class HomeRepository with MixinCardFeature {
  @override
  RestClient client;
  HomeRepository(this.client);
}
