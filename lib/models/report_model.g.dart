// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportModel _$ReportModelFromJson(Map<String, dynamic> json) => ReportModel(
      reportId: (json['reportId'] as num).toInt(),
      reportDate: DateTime.parse(json['reportDate'] as String),
      reportTitle: json['reportTitle'] as String,
      reportDescription: json['reportDescription'] as String,
      reportText: json['reportText'] as String,
    );

Map<String, dynamic> _$ReportModelToJson(ReportModel instance) => <String, dynamic>{
      'reportId': instance.reportId,
      'reportDate': instance.reportDate,
      'reportTitle': instance.reportTitle,
      'reportDescription': instance.reportDescription,
      'reportText': instance.reportText,
    };
