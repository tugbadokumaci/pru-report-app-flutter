import 'package:qr_code_app/utils/resource.dart';

import '../../models/card_model.dart';

abstract class SavedState {}

class SavedInitial extends SavedState {}

class SavedLoading extends SavedState {}

class SavedSuccess extends SavedState {
  final Resource<List<CardModel>> savedCardResource;
  SavedSuccess({required this.savedCardResource});
}

class SavedPasswordChange extends SavedState {}

class SavedError extends SavedState {}
