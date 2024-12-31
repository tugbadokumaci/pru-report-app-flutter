// import 'package:easy_localization/easy_localization.dart';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'constants/constants.dart';
import 'navigator_key.dart';
import 'routes.dart';
import 'service_locator.dart';
import 'shared_preferences_service.dart';
import 'utils/custom_colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection();
  await SharedPreferencesService.initialize();
  await Firebase.initializeApp();

  // await EasyLocalization.ensureInitialized();

  // runApp(EasyLocalization(
  //   supportedLocales: Localization.SUPPORTED_LANGUAGES,
  //   path: Localization.LANG_PATH,
  //   fallbackLocale: Localization.SUPPORTED_LANGUAGES[0],
  //   child: const MyApp(),
  // ));
  HttpOverrides.global = MyHttpOverrides();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      // locale: context.locale,
      // supportedLocales: context.supportedLocales,
      // localizationsDelegates: context.localizationDelegates,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        dividerColor: Colors.transparent,
        // primaryTextTheme: Typography(platform: TargetPlatform.iOS).white,
        // textTheme: Typography(platform: TargetPlatform.iOS).white,
        // textTheme: Typography.whiteCupertino,
        // colorScheme: const ColorScheme.light().copyWith(primary: Colors.red),
        bottomAppBarTheme: const BottomAppBarTheme(shape: CircularNotchedRectangle()),
        progressIndicatorTheme: const ProgressIndicatorThemeData(color: Colors.red),
        // iconTheme: IconThemeData(color: CustomColors.bwyRed),
        // inputDecorationTheme: InputDecorationTheme(
        //   filled: true,
        //   fillColor: CustomColors.darkGrey,
        //   border: OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(10),
        //     borderSide: BorderSide.none,
        //   ),
        //   focusedBorder: OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(10),
        //     borderSide: BorderSide.none,
        //   ),
        // ),
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android: NoAnimationPageTransitionsBuilder(),
            TargetPlatform.iOS: NoAnimationPageTransitionsBuilder(),
          },
        ),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: CustomColors.bwyYellowPastel, // but now it should be declared like this
        ),
      ),
      onGenerateRoute: RouteGenerator.GenerateRoute,
      initialRoute: splashRoute,
    );
  }
}

class NoAnimationPageTransitionsBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child; // No animation, return the child directly
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
