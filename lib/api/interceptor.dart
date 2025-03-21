import 'package:dio/dio.dart' show ErrorInterceptorHandler, Interceptor;
import 'package:flutter/material.dart' show BuildContext;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:popcorn_time/utils/navigation_service.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


class CustomDioInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    bool internetConnection = await InternetConnectionChecker().hasConnection;
    if(!internetConnection)
    {
      NavigationService.instance.navigateTo('/noInternet');
    }

    handler.next(err);
  }
}
