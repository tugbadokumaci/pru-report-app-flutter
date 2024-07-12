import 'package:flutter/rendering.dart';
import '../models/user_model.dart';

class Constants {
  Constants._();

  static UserModel USER = UserModel(
    userId: 0,
    userName: '',
    userSurname: '',
    userEmail: '',
    userPassword: '',
  );
}

const EdgeInsets kHorizontalPadding = EdgeInsets.symmetric(horizontal: 15.0);
const EdgeInsets kVerticalPadding = EdgeInsets.symmetric(vertical: 15.0);
const EdgeInsets kAllPadding = EdgeInsets.all(15.0);

const String splashRoute = '/splash';
const String homeRoute = '/home';
const String welcomeRoute = '/';
const String loginRoute = '/logIn';
const String signupRoute = '/signUp';
const String bwyRoute = '/bwy';
const String mediaRoute = '/media';
const String announcementRoute = '/announcement';
const String profileRoute = '/profile';
const String validationRoute = '/validation';
const String sampleReport = '/sampleReport';
const String reportsRoute = '/reports';
const String contactRoute = '/contact';

class ApiConstants {
  ApiConstants._();
  static const String BASE_URL = "https://www.codeocean.net";
}

const String phoneNumber = '+902244083848';
const String officeAddress = 'Beşevler Konak Mh. Burgaz Sk. No:2-A Nilüfer / BURSA';
const String emailAddress = 'info@bursawebyazilim.com';

class Localization {
  static const SUPPORTED_LANGUAGES = [
    TR_LOCALE,
    EN_LOCALE,
    DE_LOCALE,
  ];

  static const TR_LOCALE = Locale("tr", "TR");
  static const EN_LOCALE = Locale("en", "US");
  static const DE_LOCALE = Locale("de", "DE");
  static const LANG_PATH = "assets/lang";
}
