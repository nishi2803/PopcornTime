import 'package:dio/dio.dart';

class ApiExceptions implements Exception {
  String? message;
  String? errorCode;

  ApiExceptions.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioExceptionType.connectionTimeout:
        message = "Connection timeout with API server";
        break;
      case DioExceptionType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioExceptionType.badResponse:
        _handleError(
          dioException.response?.statusCode,
          dioException.response?.data,
        );
        break;
      case DioExceptionType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;

      default:
        message = "Something went wrong";
        break;
    }
  }

  void _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        message = error['status_message'];
        errorCode = error['status_code'];
        break;
      case 422:
        message = error['status_message'];
        errorCode = error['status_code'];
        break;
      case 404:
        message = error['status_message'];
        errorCode = error['status_code'];
        break;
      case 401:
        message = 'Unauthorized';
        break;
      case 403:
        message = error['status_message'];
        errorCode = error['status_code'];
        break;
      case 500:
        message = 'Internal server error';
        break;
      case 502:
        message = 'Bad gateway';
        break;
      default:
        message = 'Oops something went wrong';
        break;
    }

  }
}
