import 'package:dio/dio.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'interceptors/connectivity_interceptor.dart';
import 'interceptors/logging_interceptor.dart';
import 'interceptors/retry_interceptor.dart';

/// Singleton Dio client for the entire app.
/// All features use this instance, never create their own Dio.
class NetworkClient {
  late final Dio _dio;
  final InternetConnection _connectivityChecker;

  NetworkClient({required InternetConnection connectivityChecker})
    : _connectivityChecker = connectivityChecker {
    _dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 15),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    // Attach interceptors in order
    _dio.interceptors.add(
      ConnectivityInterceptor(connectivityChecker: _connectivityChecker),
    );
    _dio.interceptors.add(RetryInterceptor(dio: _dio));
    _dio.interceptors.add(LoggingInterceptor());
  }

  /// Returns the configured Dio instance
  Dio get dio => _dio;

  /// Factory method to create a new CancelToken
  CancelToken createCancelToken() {
    return CancelToken();
  }
}
