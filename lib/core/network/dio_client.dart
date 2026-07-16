import 'package:dio/dio.dart';
import 'package:e_commerce/core/constants/url_api.dart';
import 'package:e_commerce/features/auth/data/LocalDataSource/auth_local_data_source.dart';
import 'package:flutter/foundation.dart';


class DioClient {
  final Dio dio;
  final AuthLocalDataSource localDataSource;

  DioClient(this.localDataSource)
      : dio = Dio(
    BaseOptions(
      baseUrl: url,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  ) {
    _setupInterceptors();
  }

  void _setupInterceptors() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await localDataSource.getToken();

          if (token != null && token.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $token";
          } else {
            debugPrint("⚠️ TOKEN IS NULL OR EMPTY!");
          }

          debugPrint("Headers: ${options.headers}");
          if (kDebugMode) {
            debugPrint("➡️ REQUEST: ${options.method} ${options.path}");
            debugPrint("DATA: ${options.data}");
            debugPrint("DATA queryParameters: ${options.queryParameters}");
          }

          return handler.next(options);
        },
        onResponse: (response, handler) {
          if (kDebugMode) {
            debugPrint("✅ RESPONSE: ${response.statusCode}");
            debugPrint("DATA: ${response.data}");
          }

          return handler.next(response);
        },
        onError: (DioException e, handler) {
          if (kDebugMode) {
            debugPrint("❌ ERROR: ${e.response?.statusCode}");
            debugPrint("❌ ERROR TYPE: ${e.type}");
            debugPrint("📑MESSAGE: ${e.response?.data}");
          }

          return handler.next(e);
        },
      ),
    );
  }

}