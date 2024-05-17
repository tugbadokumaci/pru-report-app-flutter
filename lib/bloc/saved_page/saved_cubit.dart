import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_app/bloc/saved_page/saved_repository.dart';

import '../../models/card_model.dart';
import '../../utils/resource.dart';
import 'saved_state.dart';

class SavedCubit extends Cubit<SavedState> {
  final SavedRepository _repo;

  late Resource<List<CardModel>> savedCardResource;
  SavedCubit({
    required SavedRepository repo,
  })  : _repo = repo,
        super(SavedInitial());

  Future<void> getSavedCards() async {
    emit(SavedLoading());

    savedCardResource = await _repo.getSavedCards();
    if (savedCardResource.status == Status.SUCCESS) {
      emit(SavedSuccess(savedCardResource: savedCardResource));
      debugPrint('get services success');
    } else {
      debugPrint('Error while fetching service data');
      emit(SavedError());
    }
  }
}
