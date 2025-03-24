import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:popcorn_time/api/api_endpoints.dart';
import 'package:popcorn_time/api/api_exceptions.dart';
import 'package:popcorn_time/api/dio_client.dart';
import 'package:popcorn_time/config/env.dart';
import 'package:popcorn_time/models/movie_list_model.dart';

class ApiService {

   Dio dio = getClient(baseUrl: Env.baseUrl, token: Env.accessToken);

   Future<MovieListModel> fetchMoviesList(int page) async {
     try {
       final response = await dio.get(
         ApiEndpoint.fetchMovies,
         queryParameters: {
           'language': 'en-US',
           'page': page,

         },
       );

       if (response.statusCode == 200) {
         return MovieListModel.fromJson(response.data);
       } else {
         throw Exception("Failed to fetch movies");
       }
     } on DioException catch (e) {
       throw ApiExceptions.fromDioException(e);
     }
   }

   Future<MovieListModel> searchMovies(String query) async {
     try {
       final response = await dio.get(
         ApiEndpoint.search,
         queryParameters: {
           "query" : query
         },
       );

       if (response.statusCode == 200) {
         return MovieListModel.fromJson(response.data);
       } else {
         throw Exception("Failed to fetch movies");
       }
     } on DioException catch (e) {
       throw ApiExceptions.fromDioException(e);
     }
   }
}