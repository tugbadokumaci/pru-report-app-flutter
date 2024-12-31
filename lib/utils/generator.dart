import 'dart:convert';

import 'package:qr_code_app/models/eu_project_model.dart';
import 'package:qr_code_app/utils/resource.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter/material.dart';
import 'package:retrofit/retrofit.dart';

import '../models/bulletin_model.dart';
import '../models/card_model.dart';
import '../models/news_model.dart';
import '../models/post_model.dart';
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

  // @GET('/getallpages.php')
  // @Headers(<String, dynamic>{
  //   "Content-Type": "application/json",
  //   "charset": "utf-8",
  // })
  // Future<Resource<List<PageModel>>> getAllPages();

  @GET('/getallprojects.php')
  @Headers(<String, dynamic>{
    "Content-Type": "application/json",
    "charset": "utf-8",
  })
  Future<Resource<List<EUProjectModel>>> getAllProjects();

  @GET('/getallnews.php')
  @Headers(<String, dynamic>{
    "Content-Type": "application/json",
    "charset": "utf-8",
  })
  Future<Resource<List<News>>> getAllNews();

  @GET('/getallbulletin.php')
  @Headers(<String, dynamic>{
    "Content-Type": "application/json",
    "charset": "utf-8",
  })
  Future<Resource<List<Bulletin>>> getAllBulletin();

  @GET('/getallposts.php')
  @Headers(<String, dynamic>{
    "Content-Type": "application/json",
    "charset": "utf-8",
  })
  Future<Resource<List<PostModel>>> getAllPosts();

  // @POST('/getcards.php')
  // @Headers(<String, dynamic>{
  //   "Content-Type": "application/json",
  //   "charset": "utf-8",
  // })
  // Future<Resource<List<CardModel>>> getCards(@Body() Map<String, dynamic> userId);

  @POST('/getsavedcards.php')
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

  @POST('/register.php')
  @Headers(<String, dynamic>{
    "Content-Type": "application/json",
    "charset": "utf-8",
  })
  Future<Resource<UserModel>> signup(@Body() Map<String, dynamic> user);

  @POST('/login.php')
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
