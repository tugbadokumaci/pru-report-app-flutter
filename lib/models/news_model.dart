import 'package:json_annotation/json_annotation.dart';

part 'news_model.g.dart';

@JsonSerializable()
class News {
  final int id;
  final String title;
  final String content;
  final String coverImage;
  final List<String> photoGallery;

  News({
    required this.id,
    required this.title,
    required this.content,
    required this.coverImage,
    required this.photoGallery,
  });

  // JSON'dan News modeline dönüşüm
  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);

  // News modelinden JSON'a dönüşüm
  Map<String, dynamic> toJson() => _$NewsToJson(this);
}

@JsonSerializable()
class NewsResponse {
  final List<News> data;

  NewsResponse({required this.data});

  // JSON'dan NewsResponse modeline dönüşüm
  factory NewsResponse.fromJson(Map<String, dynamic> json) => _$NewsResponseFromJson(json);

  // NewsResponse modelinden JSON'a dönüşüm
  Map<String, dynamic> toJson() => _$NewsResponseToJson(this);
}
