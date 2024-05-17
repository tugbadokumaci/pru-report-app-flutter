// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import 'bloc/home_page/home_cubit.dart';
import 'bloc/home_page/home_repository.dart';
import 'bloc/home_page/home_view.dart';
import 'bloc/profile_page/profile_cubit.dart';
import 'bloc/profile_page/profile_repository.dart';
import 'bloc/profile_page/profile_view.dart';
import 'bloc/saved_page/saved_cubit.dart';
import 'bloc/saved_page/saved_repository.dart';
import 'bloc/saved_page/saved_view.dart';
import 'bloc/scan_page/scan.repository.dart';
import 'bloc/scan_page/scan_cubit.dart';
import 'bloc/scan_page/scan_view.dart';
import 'bloc/welcome_page/welcome_cubit.dart';
import 'bloc/welcome_page/welcome_repository.dart';
import 'bloc/welcome_page/welcome_view.dart';
import 'constants/constants.dart';
import 'service_locator.dart';

class RouteGenerator {
  static Route<dynamic> GenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(
            settings: settings, builder: (_) => HomeView(viewModel: HomeCubit(repo: locator.get<HomeRepository>())));
      case welcomeRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            return WelcomeView(viewModel: WelcomeCubit(repo: locator.get<WelcomeRepository>()));
          },
        );
      // case loginRoute:
      //   return MaterialPageRoute(
      //       settings: settings, builder: (_) => LoginView(viewModel: LoginCubit(repo: locator.get<LoginRepository>())));
      // case signupRoute:
      //   return MaterialPageRoute(
      //       settings: settings,
      //       builder: (_) => SignupView(viewModel: SignupCubit(repo: locator.get<SignupRepository>())));
      // case validationRoute:
      case scanRoute:
        return MaterialPageRoute(
            settings: settings, builder: (_) => ScanView(viewModel: ScanCubit(repo: locator.get<ScanRepository>())));

      case profileRoute:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => ProfileView(viewModel: ProfileCubit(repo: locator.get<ProfileRepository>())));
      case savedRoute:
        return MaterialPageRoute(
            settings: settings, builder: (_) => SavedView(viewModel: SavedCubit(repo: locator.get<SavedRepository>())));

      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
