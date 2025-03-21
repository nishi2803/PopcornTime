
import 'package:dio/dio.dart';
import 'package:popcorn_time/api/interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';



Map<String, String> getHeaders(String? token) {
  return {
    "Accept": "application/json",
    'Content-Type': 'application/json',
    if (token != "") 'Authorization': 'Bearer $token',
  };
}

Dio getClient({required String baseUrl, required String? token})  {
  final Dio dioClient = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 30),
      sendTimeout: Duration(seconds: 30),
      headers:  getHeaders(token),
    ),
  );

  dioClient.interceptors.add(PrettyDioLogger(requestBody: true, requestHeader: true, responseBody: true));
  dioClient.interceptors.add(CustomDioInterceptor());

  return dioClient;
}

