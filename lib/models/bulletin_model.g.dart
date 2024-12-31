part of 'bulletin_model.dart';

Bulletin _$BulletinFromJson(Map<String, dynamic> json) => Bulletin(
      id: json['id'] as int,
      baslik: json['baslik'] as String,
      kapakResmi: json['kapak_resmi'] as String,
      pdfDosyasi: json['pdf_dosyasi'] as String,
    );

Map<String, dynamic> _$BulletinToJson(Bulletin instance) => <String, dynamic>{
      'id': instance.id,
      'baslik': instance.baslik,
      'kapak_resmi': instance.kapakResmi,
      'pdf_dosyasi': instance.pdfDosyasi,
    };
