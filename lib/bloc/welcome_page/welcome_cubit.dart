import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/user_model.dart';
import '../../shared_preferences_service.dart';
import '../../utils/resource.dart';
import 'welcome_repository.dart';
import 'welcome_state.dart';

class WelcomeCubit extends Cubit<WelcomeState> {
  final WelcomeRepository _repo;

  WelcomeCubit({
    required WelcomeRepository repo,
  })  : _repo = repo,
        super(WelcomeInitial());

  Future<void> initialize(BuildContext context) async {
    emit(WelcomeLoading());
    final email = await SharedPreferencesService.getEmailPreference();
    final password = await SharedPreferencesService.getPasswordPreference();

    if (email != '' && password != '') {
      Resource<UserModel> resource = await _repo.login(email, password);
      Navigator.pushNamed(context, '/home'); // Otomatik olarak ana sayfaya yönlendir
    } else {
      emit(WelcomeSuccess());
    }
  }
}
