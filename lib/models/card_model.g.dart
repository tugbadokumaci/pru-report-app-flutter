// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardModel _$CardModelFromJson(Map<String, dynamic> json) => CardModel(
      cardId: (json['cardId'] as num).toInt(),
      creatorId: json['creatorId'] as String,
      displayName: json['displayName'] as String,
      jobTitle: json['jobTitle'] as String,
      phone: json['phone'] as String,
      mail: json['mail'] as String,
      websiteUrl: json['websiteUrl'] as String,
      address: json['address'] as String,
      updatedDate: json['updatedDate'] as String,
      isActive: json['isActive'] as bool,
      createdDate: DateTime.parse(json['createdDate'] as String),
      cardBgColor: json['cardBgColor'] as String,
    );

Map<String, dynamic> _$CardModelToJson(CardModel instance) => <String, dynamic>{
      'cardId': instance.cardId,
      'creatorId': instance.creatorId,
      'displayName': instance.displayName,
      'jobTitle': instance.jobTitle,
      'phone': instance.phone,
      'mail': instance.mail,
      'websiteUrl': instance.websiteUrl,
      'address': instance.address,
      'updatedDate': instance.updatedDate,
      'isActive': instance.isActive,
      'createdDate': instance.createdDate.toIso8601String(),
      'cardBgColor': instance.cardBgColor,
    };
