import 'package:qr_code_app/utils/generator.dart';

import '../../inheritance/mixin_card_feature.dart';

class MediaRepository with MixinCardFeature {
  @override
  RestClient client;
  MediaRepository(this.client);
}
