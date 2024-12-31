import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_app/bloc/bulletin_page/bulletin_state.dart';
import 'package:qr_code_app/utils/resource.dart';

import '../../models/bulletin_model.dart';
import 'bulletin_repository.dart';

class BulletinCubit extends Cubit<BulletinState> {
  final BulletinRepository _repo;

  late Resource<List<Bulletin>> bulletinResource;
  BulletinCubit({
    required BulletinRepository repo,
  })  : _repo = repo,
        super(BulletinInitial());

  Future<void> getAllBulletin() async {
    emit(BulletinLoading());
    bulletinResource = await _repo.getAllBulletin();
    if (bulletinResource.status == Status.SUCCESS) {
      emit(BulletinSuccess(bulletinResource: bulletinResource));
    } else {
      emit(BulletinError(message: bulletinResource.errorMessage!));
    }
  }
}
