import 'package:json_annotation/json_annotation.dart';

part 'report_model.g.dart';

@JsonSerializable()
class ReportModel {
  int reportId;
  DateTime reportDate;
  String reportTitle;
  String reportDescription;
  String reportText;

  ReportModel({
    required this.reportId,
    required this.reportDate,
    required this.reportTitle,
    required this.reportDescription,
    required this.reportText,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) => _$ReportModelFromJson(json);
  Map<String, dynamic> toJson() => _$ReportModelToJson(this);
}
