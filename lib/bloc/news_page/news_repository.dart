import '../../inheritance/mixin_card_feature.dart';
import '../../utils/generator.dart';

class NewsRepository with MixinCardFeature {
  @override
  RestClient client;
  NewsRepository(this.client);
}
