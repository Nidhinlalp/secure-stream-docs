import 'package:dio/dio.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

/// Interceptor that blocks requests when there is no internet connection.
/// Checks connectivity before every request and rejects immediately if offline.
class ConnectivityInterceptor extends Interceptor {
  final InternetConnection connectivityChecker;

  ConnectivityInterceptor({required this.connectivityChecker});

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final isConnected = await connectivityChecker.hasInternetAccess;

      if (!isConnected) {
        handler.reject(
          DioException(
            requestOptions: options,
            type: DioExceptionType.connectionError,
            message: 'No internet connection',
          ),
        );
        return;
      }

      // Connected, proceed with the request
      handler.next(options);
    } catch (e) {
      // If connectivity check fails, reject the request
      handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.connectionError,
          message: 'Unable to check internet connection: $e',
        ),
      );
    }
  }
}
