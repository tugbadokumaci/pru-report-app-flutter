// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:qr_code_app/bloc/reports_page/reports_view.dart';
import 'package:qr_code_app/sample_report.dart';

import 'bloc/home_page/home_cubit.dart';
import 'bloc/home_page/home_repository.dart';
import 'bloc/home_page/home_view.dart';
import 'bloc/reports_page/reports_cubit.dart';
import 'bloc/reports_page/reports_repository.dart';
import 'bloc/settings_page/settings_cubit.dart';
import 'bloc/settings_page/settings_repository.dart';
import 'bloc/settings_page/settings_view.dart';
import 'bloc/announcement_page/announcement_cubit.dart';
import 'bloc/announcement_page/announcement_repository.dart';
import 'bloc/announcement_page/announcement_view.dart';
import 'bloc/media_page/media_repository.dart';
import 'bloc/media_page/media_cubit.dart';
import 'bloc/media_page/media_view.dart';
import 'bloc/welcome_page/welcome_cubit.dart';
import 'bloc/welcome_page/welcome_repository.dart';
import 'bloc/welcome_page/welcome_view.dart';
import 'constants/constants.dart';
import 'contact_page.dart';
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
      case mediaRoute:
        return MaterialPageRoute(
            settings: settings, builder: (_) => MediaView(viewModel: MediaCubit(repo: locator.get<MediaRepository>())));

      case profileRoute:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => SettingsView(viewModel: SettingsCubit(repo: locator.get<ProfileRepository>())));
      case announcementRoute:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) =>
                AnnouncementView(viewModel: AnnouncementCubit(repo: locator.get<AnnouncementRepository>())));
      case reportsRoute:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => ReportsView(viewModel: ReportsCubit(repo: locator.get<ReportsRepository>())));
      case sampleReport:
        return MaterialPageRoute(settings: settings, builder: (_) => SampleReport());
      case contactRoute:
        return MaterialPageRoute(settings: settings, builder: (_) => ContactPage());

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
