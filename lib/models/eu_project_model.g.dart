// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eu_project_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EUProjectModel _$EUProjectModelFromJson(Map<String, dynamic> json) {
  return EUProjectModel(
    projectId: json['projectId'] as int,
    generalInfo:
        (json['generalInfo'] as List<dynamic>).map((e) => GeneralInfo.fromJson(e as Map<String, dynamic>)).toList(),
    featuredImage: json['featuredImage'] as String,
    events: (json['events'] as List<dynamic>?)
        ?.map((nestedList) => (nestedList as List<dynamic>?)
            ?.map((e) => e == null ? null : EUMetaData.fromJson(e as Map<String, dynamic>))
            .toList())
        .toList(),
    news: (json['news'] as List<dynamic>?)
        ?.map((nestedList) => (nestedList as List<dynamic>?)
            ?.map((e) => e == null ? null : EUMetaData.fromJson(e as Map<String, dynamic>))
            .toList())
        .toList(),
  );
}

// EUProjectModel _$EUProjectModelFromJson(Map<String, dynamic> json) => EUProjectModel(
//       projectId: json['projectId'] as int,
//       generalInfo:
//           (json['generalInfo'] as List<dynamic>).map((e) => GeneralInfo.fromJson(e as Map<String, dynamic>)).toList(),
//       featuredImage: json['featuredImage'] as String,
//       events: (json['events'] as List<dynamic>?)?.map((e) => EUEvent.fromJson(e as Map<String, dynamic>)).toList(),
//       news: (json['news'] as List<dynamic>?)?.map((e) => EUNews.fromJson(e as Map<String, dynamic>)).toList(),
//       // events: (json['events'] as List<dynamic>?)?.map((e) => EUEvent.fromJson(e as Map<String, dynamic>)).toList(),
//       // news: (json['news'] as List<dynamic>?)?.map((e) => EUNews.fromJson(e as Map<String, dynamic>)).toList(),
//       // // news: (json['news'] as List<dynamic>?)?.map((e) {
//       //   // meta_value kontrolü yapılmalı
//       //   final metaValue = e['meta_value']== null ? '' : e['meta_value'];
//       //   if (metaValue == null) {
//       //     e['meta_value'] = ''; // null ise boş string olarak ayarlanıyor
//       //   }
//       //   return EUNews.fromJson(e as Map<String, dynamic>);
//       // }).toList(),
//     );

Map<String, dynamic> _$EUProjectModelToJson(EUProjectModel instance) => <String, dynamic>{
      'projectId': instance.projectId,
      'generalInfo': instance.generalInfo.map((e) => e.toJson()).toList(),
      'featuredImage': instance.featuredImage,
      'events': instance.events?.map((nestedList) => nestedList?.map((e) => e?.toJson()).toList()).toList(),
      // 'news': instance.news?.map((e) => e.toJson()).toList(),
    };

// Map<String, dynamic> _$EUProjectModelToJson(EUProjectModel instance) => <String, dynamic>{
//       'projectId': instance.projectId,
//       'generalInfo': instance.generalInfo.map((e) => e.toJson()).toList(),
//       'featuredImage': instance.featuredImage,
//       'events': instance.events?.map((e) => e.toJson()).toList(),
//       // 'news': instance.news?.map((e) => e.toJson()).toList(),
//     };
GeneralInfo _$GeneralInfoFromJson(Map<String, dynamic> json) => GeneralInfo(
      metaKey: json['meta_key'] as String,
      metaValue: json['meta_value'] as String,
    );

Map<String, dynamic> _$GeneralInfoToJson(GeneralInfo instance) => <String, dynamic>{
      'meta_key': instance.metaKey,
      'meta_value': instance.metaValue,
    };

// EUEvent _$EUEventFromJson(Map<String, dynamic> json) => EUEvent(
//       metaKey: json['meta_key'] as String,
//       metaValue: json['meta_value'] ?? '',
//     );

// Map<String, dynamic> _$EUEventToJson(EUEvent instance) => <String, dynamic>{
//       'meta_key': instance.metaKey,
//       'meta_value': instance.metaValue,
//     };

// EUNews _$EUNewsFromJson(Map<String, dynamic> json) => EUNews(
//       metaKey: json['meta_key'] as String,
//       metaValue: json['meta_value'] ?? '',
//     );

// Map<String, dynamic> _$EUNewsToJson(EUNews instance) => <String, dynamic>{
//       'meta_key': instance.metaKey,
//       'meta_value': instance.metaValue,
//     };

EUMetaData _$EUMetaDataFromJson(Map<String, dynamic> json) => EUMetaData(
      metaKey: json['meta_key'] as String,
      metaValue: json['meta_value'] ?? '',
    );

Map<String, dynamic> _$EUMetaDataToJson(EUMetaData instance) => <String, dynamic>{
      'meta_key': instance.metaKey,
      'meta_value': instance.metaValue,
    };
