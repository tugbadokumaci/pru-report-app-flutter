import 'package:json_annotation/json_annotation.dart';

part 'bulletin_model.g.dart';

@JsonSerializable()
class Bulletin {
  final int id;
  final String baslik;
  final String kapakResmi;
  final String pdfDosyasi;

  Bulletin({
    required this.id,
    required this.baslik,
    required this.kapakResmi,
    required this.pdfDosyasi,
  });

  // JSON verisini model nesnesine dönüştürme
  factory Bulletin.fromJson(Map<String, dynamic> json) => _$BulletinFromJson(json);

  // Model nesnesini JSON formatına dönüştürme
  Map<String, dynamic> toJson() => _$BulletinToJson(this);
}
