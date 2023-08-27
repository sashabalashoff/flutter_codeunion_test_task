import 'dart:async';

import 'package:dio/dio.dart';

import '../data/models/auth_data.dart';
import '../data/models/server_error.dart';

abstract class ApiService {
  void updateAccessToken(String? accessToken);

  Future<AuthData> authLogin({
    required String email,
    required String password,
  });
}

class ApiServiceImpl implements ApiService {
  static const _baseUrl = 'http://45.10.110.181:8080/api/v1';

  final dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      contentType: 'application/json',
    ),
  );

  @override
  void updateAccessToken(String? authToken) {
    final headers = dio.options.headers;
    if (authToken == null) {
      headers.remove('Authorization');
    } else {
      headers['Authorization'] = 'Bearer $authToken';
    }
    dio.options = dio.options.copyWith(headers: headers);
  }

  Future<Response<T>> _dioPost<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response;
    } catch (e) {
      if (e is DioException) {
        final error = e.response?.data as Map<String, dynamic>?;

        if (error != null) {
          throw ServerError.fromJson(error);
        }
      }

      rethrow;
    }
  }

  @override
  Future<AuthData> authLogin({
    required String email,
    required String password,
  }) async {
    final response = await _dioPost<dynamic>(
      '/auth/login',
      data: {
        'email': email,
        'password': password,
      },
    );

    return AuthData.fromJson(response.data as Map<String, dynamic>);
  }
}
