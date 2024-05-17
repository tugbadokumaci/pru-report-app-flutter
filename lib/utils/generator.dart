import 'dart:convert';

import 'package:qr_code_app/utils/resource.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter/material.dart';
import 'package:retrofit/retrofit.dart';

import '../models/card_model.dart';
import '../models/user_model.dart';
import '../constants/constants.dart';

part 'generator.g.dart';

@RestApi(baseUrl: ApiConstants.BASE_URL)
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  static RestClient create() {
    final dio = Dio();
    RestClient.debugHttpInterceptors(dio); // Burada çağrılıyor
    return RestClient(dio);
  }

  @GET('/qr_code_app/getcards.php')
  @Headers(<String, dynamic>{
    "Content-Type": "application/json",
    "charset": "utf-8",
  })
  Future<Resource<List<CardModel>>> getCards(@Body() Map<String, dynamic> userId);

  @POST('/qr_code_app/getsavedcards.php')
  @Headers(<String, dynamic>{
    "Content-Type": "application/json",
    "charset": "utf-8",
  })
  Future<Resource<List<CardModel>>> getSavedCards(@Body() Map<String, dynamic> userId);

  // @POST('/qr_code_app/getsavedcards.php')
  // @Headers(<String, dynamic>{
  //   "Content-Type": "application/json",
  //   "charset": "utf-8",
  // })
  // Future<Resource<List<CardModel>>> getSavedCards(@Body() Map<String, dynamic> userId);

  @POST('/qr_code_app/register.php')
  @Headers(<String, dynamic>{
    "Content-Type": "application/json",
    "charset": "utf-8",
  })
  Future<Resource<UserModel>> signup(@Body() Map<String, dynamic> user);

  @POST('/qr_code_app/login.php')
  @Headers(
      <String, dynamic>{"Content-Type": "application/json", "charset": "utf-8", "Access-Control-Allow-Origin": "*"})
  Future<Resource<UserModel>> login(@Body() Map<String, dynamic> user);

  @POST('/qr_code_app/changepassword.php')
  @Headers(<String, dynamic>{
    "Content-Type": "application/json",
    "charset": "utf-8",
  })
  Future<Resource<bool>> changePassword(@Body() Map<String, dynamic> newPassword);

  @POST('/qr_code_app/sendotp.php')
  @Headers(<String, dynamic>{
    "Content-Type": "application/json",
    "charset": "utf-8",
  })
  Future<Resource<bool>> sendOtp(@Body() Map<String, dynamic> emailInfo);

  @POST('/qr_code_app/validateotp.php')
  @Headers(<String, dynamic>{
    "Content-Type": "application/json",
    "charset": "utf-8",
  })
  Future<Resource<bool>> validateOtp(@Body() Map<String, dynamic> emailInfo);

  @POST('/qr_code_app/deleteaccount.php')
  @Headers(<String, dynamic>{
    "Content-Type": "application/json",
    "charset": "utf-8",
  })
  Future<Resource<bool>> deleteAccount(@Body() Map<String, dynamic> userEmail);

  static void debugHttpInterceptors(Dio dio) {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        debugPrint('onRequest');
        debugPrint("--> ${options.method} ${options.uri}");
        debugPrint("Headers: ${options.headers}");
        debugPrint("Data: ${options.data}");
        return handler.next(options);
      },
      onResponse: (response, handler) {
        debugPrint('onResponse');
        debugPrint("<-- ${response.statusCode} ${response.requestOptions.uri}");
        debugPrint("Response: ${response.data}");
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        debugPrint('onError');
        debugPrint("<-- Error ${e.response?.statusCode} ${e.response?.requestOptions.uri}");
        debugPrint("Message: ${e.message}");
        return handler.next(e);
      },
    ));
  }
}
