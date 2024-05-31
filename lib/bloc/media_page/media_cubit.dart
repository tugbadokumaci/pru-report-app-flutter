import 'package:flutter_bloc/flutter_bloc.dart';

import 'media_repository.dart';
import 'media_state.dart';

class MediaCubit extends Cubit<MediaState> {
  final MediaRepository _repo;
  MediaCubit({
    required MediaRepository repo,
  })  : _repo = repo,
        super(MediaSuccess());
  // void scan() async {
  //   final result = await BarcodeScanner.scan();
  //   emit(ScanSuccess(result.rawContent));
  // }
}
