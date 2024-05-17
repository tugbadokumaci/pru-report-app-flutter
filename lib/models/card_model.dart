import 'package:json_annotation/json_annotation.dart';

part 'card_model.g.dart';

@JsonSerializable()
class CardModel {
  int cardId;
  String creatorId;
  String displayName;
  String jobTitle;
  String phone;
  String mail;
  String websiteUrl;
  String address;
  String updatedDate;
  bool isActive;
  DateTime createdDate;
  String cardBgColor;

  CardModel(
      {required this.cardId,
      required this.creatorId,
      required this.displayName,
      required this.jobTitle,
      required this.phone,
      required this.mail,
      required this.websiteUrl,
      required this.address,
      required this.updatedDate,
      required this.isActive,
      required this.createdDate,
      required this.cardBgColor});

  factory CardModel.fromJson(Map<String, dynamic> json) => _$CardModelFromJson(json);
  Map<String, dynamic> toJson() => _$CardModelToJson(this);
}
