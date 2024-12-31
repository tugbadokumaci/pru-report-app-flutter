import 'package:json_annotation/json_annotation.dart';

part 'eu_project_model.g.dart';

@JsonSerializable()
class EUProjectModel {
  final int projectId;
  final List<GeneralInfo> generalInfo;
  final String featuredImage;
  final List<List<EUMetaData?>?>? events;
  final List<List<EUMetaData?>?>? news;

  EUProjectModel({
    required this.projectId,
    required this.generalInfo,
    required this.featuredImage,
    this.events,
    this.news,
  });

  factory EUProjectModel.fromJson(Map<String, dynamic> json) => _$EUProjectModelFromJson(json);

  Map<String, dynamic> toJson() => _$EUProjectModelToJson(this);

  // Yardımcı fonksiyon
  String? getGeneralInfoValue(String key) {
    return generalInfo
        .firstWhere(
          (info) => info.metaKey == key,
          orElse: () => GeneralInfo(metaKey: '', metaValue: ''),
        )
        .metaValue;
  }
}

@JsonSerializable()
class GeneralInfo {
  @JsonKey(name: 'meta_key')
  final String metaKey;
  @JsonKey(name: 'meta_value')
  final String metaValue;

  GeneralInfo({
    required this.metaKey,
    required this.metaValue,
  });

  factory GeneralInfo.fromJson(Map<String, dynamic> json) => _$GeneralInfoFromJson(json);

  Map<String, dynamic> toJson() => _$GeneralInfoToJson(this);
}

@JsonSerializable()
class EUMetaData {
  @JsonKey(name: 'meta_key')
  final String metaKey;
  @JsonKey(name: 'meta_value')
  final dynamic metaValue;

  EUMetaData({
    required this.metaKey,
    required this.metaValue,
  });

  factory EUMetaData.fromJson(Map<String, dynamic> json) => _$EUMetaDataFromJson(json);

  Map<String, dynamic> toJson() => _$EUMetaDataToJson(this);

  // Yardımcı fonksiyon
  dynamic getEUMetaDataValue(String key) {
    if (key == 'etkinlik-gorseller' || key == 'haberler-gorseller') {
      if (metaValue is List<dynamic>) {
        return (metaValue as List<dynamic>).map((e) => e).toList();
      } else if (metaValue == null) {
        return [];
      }
    }

    // Eğer metaValue boş string veya null ise, uygun bir değer döndür
    if (metaValue == null || metaValue is String && metaValue.isEmpty) {
      return ''; // Boş string döndür
    }

    if (metaKey == key) {
      if (metaValue is List) {
        return (metaValue as List).map((e) => e).toList();
      }
      return metaValue;
    }
  }
}

// @JsonSerializable()
// class EUNews {
//   @JsonKey(name: 'meta_key')
//   final String metaKey;
//   @JsonKey(name: 'meta_value')
//   final dynamic metaValue;

//   EUNews({
//     required this.metaKey,
//     required this.metaValue,
//   });

//   factory EUNews.fromJson(Map<String, dynamic> json) => _$EUNewsFromJson(json);

//   Map<String, dynamic> toJson() => _$EUNewsToJson(this);

//   // Yardımcı fonksiyon
//   dynamic getNewsValue(String key) {
//     if (key == 'haberler-gorseller') {
//       if (metaValue is List<dynamic>) {
//         return (metaValue as List<dynamic>).map((e) => e.toString()).toList();
//       } else if (metaValue == null) {
//         return [];
//       }
//     }
//     // Eğer metaValue boş string veya null ise, uygun bir değer döndür
//     if (metaValue == null || metaValue is String && metaValue.isEmpty) {
//       return ''; // Boş string döndür
//     }

//     if (metaKey == key) {
//       if (metaValue is List) {
//         return (metaValue as List).map((e) => e.toString()).toList();
//       }
//       return metaValue;
//     }
//   }
// }
