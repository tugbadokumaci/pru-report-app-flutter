import 'package:qr_code_app/utils/resource.dart';

import '../../models/card_model.dart';

abstract class AnnouncementState {}

class AnnouncementInitial extends AnnouncementState {}

class AnnouncementLoading extends AnnouncementState {}

class AnnouncementSuccess extends AnnouncementState {
  final Resource<List<CardModel>> savedCardResource;
  AnnouncementSuccess({required this.savedCardResource});
}

class AnnouncementError extends AnnouncementState {}
