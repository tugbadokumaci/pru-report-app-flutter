// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

News _$NewsFromJson(Map<String, dynamic> json) => News(
      id: json['id'] as int,
      title: json['baslik'] as String,
      content: json['icerik'] as String,
      coverImage: json['kapak_resmi'] as String,
      photoGallery: (json['resim_galerisi'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$NewsToJson(News instance) => <String, dynamic>{
      'id': instance.id,
      'baslik': instance.title,
      'icerik': instance.content,
      'kapak_resmi': instance.coverImage,
      'resim_galerisi': instance.photoGallery,
    };

NewsResponse _$NewsResponseFromJson(Map<String, dynamic> json) => NewsResponse(
      data: (json['data'] as List<dynamic>).map((e) => News.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$NewsResponseToJson(NewsResponse instance) => <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
    };
