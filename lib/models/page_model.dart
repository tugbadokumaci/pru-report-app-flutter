import 'package:json_annotation/json_annotation.dart';

part 'page_model.g.dart';

@JsonSerializable()
class PageModel {
  String pageId;
  String post_title;

  PageModel({
    required this.pageId,
    required this.post_title,
  });

  factory PageModel.fromJson(Map<String, dynamic> json) => _$PageModelFromJson(json);
  Map<String, dynamic> toJson() => _$PageModelToJson(this);
}
