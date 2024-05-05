import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';

enum HTTPRequestType { get, post, put, delete, update }

class NetworkServices extends GetxService {
  static const String baseURL =
      'https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com';

  late dio.Dio _dio;

  Future<NetworkServices> init() async {
    _setupDio();
    await _interceptorHandler();
    return this;
  }

  _setupDio() {
    _dio = dio.Dio();
    _dio.options.connectTimeout = const Duration(milliseconds: 300000);
    _dio.options.sendTimeout = const Duration(milliseconds: 300000);
    _dio.options.receiveTimeout = const Duration(milliseconds: 300000);
  }

  Future<dio.Response?> connectAPI({
    required HTTPRequestType requestType,
    String? fullUrl,
    String? endPoint,
    Map<String, dynamic>? header,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? bodyParameters,
    File? fileUploadBinary,
  }) async {
    dio.Response? response;

    ///GET REQUEST
    if (requestType == HTTPRequestType.get) {
      try {
        response = await _dio.get(
          fullUrl ?? '$baseURL/$endPoint',
          queryParameters: queryParameters,
          options: header != null ? dio.Options(headers: header) : null,
        );
      } catch (_) {}
    }

    ///PUT REQUEST
    if (requestType == HTTPRequestType.put) {
      try {
        response = await _dio.put(
          fullUrl ?? '$baseURL/$endPoint',
          queryParameters: queryParameters,
          data: fileUploadBinary != null
              ? fileUploadBinary.readAsBytesSync()
              : bodyParameters,
          options: header != null ? dio.Options(headers: header) : null,
        );
      } catch (_) {}
    }

    ///POST REQUEST
    if (requestType == HTTPRequestType.post) {
      try {
        response = await _dio.post(
          fullUrl ?? '$baseURL/$endPoint',
          queryParameters: queryParameters,
          data: bodyParameters,
          options: header != null ? dio.Options(headers: header) : null,
        );
      } catch (_) {}
    }

    log(
      (queryParameters != null
          ? 'query parameter :$queryParameters'
          : bodyParameters != null
              ? 'body parameter :$bodyParameters'
              : 'No parameter found'),
    );

    return response;
  }

  _interceptorHandler() async {
    _dio.interceptors.add(
      dio.QueuedInterceptorsWrapper(
        onRequest: _dioRequestHandler,
        onError: _dioErrorHandler,
      ),
    );
    _dio.interceptors.add(dio.LogInterceptor(responseBody: true));
  }

  _dioRequestHandler(
    dio.RequestOptions options,
    dio.RequestInterceptorHandler handler,
  ) {
    log(options.path);
    options.headers['Accept'] = 'application/json';
    return handler.next(options);
  }

  _dioErrorHandler(
    dio.DioException error,
    dio.ErrorInterceptorHandler handler,
  ) async {
    log('dioErrorHandle : ${error.response?.data}');
    return handler.next(error);
  }
}
