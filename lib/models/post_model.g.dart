// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
      postId: (json['postId'] as num).toInt(),
      postTitle: json['postTitle'] as String,
      aciklama_1: json['aciklama_1'] as String,
      aciklama_1_ust_baslik: json['aciklama_1_ust_baslik'] as String,
      aciklama_2: json['aciklama_2'] as String,
      aciklama_2_ust_baslik: json['aciklama_2_ust_baslik'] as String,
      postThumbnail: json['postThumbnail'] as String,
      termTaxonomyIds: (json['termTaxonomyIds'] as List<dynamic>?)?.map((e) => e as int).toList() ?? [],
      imageUrls: (json['imageUrls'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
    );

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
      'postId': instance.postId,
      'postTitle': instance.postTitle,
      'aciklama_1': instance.aciklama_1,
      'aciklama_1_ust_baslik': instance.aciklama_1_ust_baslik,
      'aciklama_2': instance.aciklama_2,
      'aciklama_2_ust_baslik': instance.aciklama_2_ust_baslik,
      'postThumbnail': instance.postThumbnail,
      'termTaxonomyIds': instance.termTaxonomyIds,
      'imageUrls': instance.imageUrls,
    };
