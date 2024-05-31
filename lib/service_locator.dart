import 'package:qr_code_app/utils/generator.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'bloc/home_page/home_repository.dart';
import 'bloc/reports_page/reports_repository.dart';
import 'bloc/settings_page/settings_repository.dart';
import 'bloc/announcement_page/announcement_repository.dart';
import 'bloc/media_page/media_repository.dart';
import 'bloc/welcome_page/welcome_repository.dart';

// import 'bloc/home_page/home_repository.dart';
// import 'bloc/login_page/login_repository.dart';
// import 'bloc/profile_page/profile_repository.dart';
// import 'bloc/signup_page/signup_repository.dart';
// import 'bloc/validation_page/vaildation_repository.dart';
// import 'bloc/welcome_page/welcome_repository.dart';

GetIt locator = GetIt.instance;

class DependencyInjection {
  DependencyInjection() {
    provideRepositories();
  }

  void provideRepositories() {
    locator.registerSingleton<Dio>(Dio());
    locator.registerSingleton<RestClient>(RestClient(locator<Dio>()));
    locator.registerFactory<WelcomeRepository>(() => WelcomeRepository());
    locator.registerFactory<HomeRepository>(() => HomeRepository(locator<RestClient>()));
    // locator.registerFactory<LoginRepository>(() => LoginRepository(locator<RestClient>()));
    // locator.registerFactory<SignupRepository>(() => SignupRepository(locator<RestClient>()));
    // locator.registerFactory<ValidationRepository>(() => ValidationRepository(locator<RestClient>()));
    locator.registerFactory<MediaRepository>(() => MediaRepository(locator<RestClient>()));
    locator.registerFactory<AnnouncementRepository>(() => AnnouncementRepository(locator<RestClient>()));
    locator.registerFactory<ProfileRepository>(() => ProfileRepository(locator<RestClient>()));
    locator.registerFactory<ReportsRepository>(() => ReportsRepository(locator<RestClient>()));
  }
}
