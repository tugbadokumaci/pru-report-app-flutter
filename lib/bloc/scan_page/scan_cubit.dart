import 'package:flutter_bloc/flutter_bloc.dart';

import 'scan.repository.dart';
import 'scan_state.dart';

class ScanCubit extends Cubit<ScanState> {
  final ScanRepository _repo;
  ScanCubit({
    required ScanRepository repo,
  })  : _repo = repo,
        super(ScanSuccess());
  // void scan() async {
  //   final result = await BarcodeScanner.scan();
  //   emit(ScanSuccess(result.rawContent));
  // }
}
