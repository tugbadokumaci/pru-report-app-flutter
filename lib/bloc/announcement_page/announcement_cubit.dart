import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_app/bloc/announcement_page/announcement_repository.dart';

import '../../models/card_model.dart';
import '../../utils/resource.dart';
import 'announcement_state.dart';

class AnnouncementCubit extends Cubit<AnnouncementState> {
  final AnnouncementRepository _repo;

  late Resource<List<CardModel>> savedCardResource;
  AnnouncementCubit({
    required AnnouncementRepository repo,
  })  : _repo = repo,
        super(AnnouncementInitial());

  Future<void> getSavedCards() async {
    emit(AnnouncementLoading());

    savedCardResource = await _repo.getSavedCards();
    if (savedCardResource.status == Status.SUCCESS) {
      emit(AnnouncementSuccess(savedCardResource: savedCardResource));
      debugPrint('get services success');
    } else {
      debugPrint('Error while fetching service data');
      emit(AnnouncementError());
    }
  }
}
