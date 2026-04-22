import 'package:dio/dio.dart';

/// Interceptor that automatically retries failed requests with exponential backoff.
/// Retries only on transient failures: connectionError, receiveTimeout, sendTimeout.
class RetryInterceptor extends Interceptor {
  static const int maxRetries = 3;

  final Dio dio;

  RetryInterceptor({required this.dio});

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Only retry on specific transient errors
    if (!_shouldRetry(err)) {
      handler.next(err);
      return;
    }

    // Get current retry count from request extras
    final retryCount = err.requestOptions.extra['retryCount'] as int? ?? 0;

    // Check if we've exceeded max retries
    if (retryCount >= maxRetries) {
      handler.next(err);
      return;
    }

    // Calculate backoff delay: 1s, 2s, 4s
    final delaySeconds = _calculateBackoff(retryCount);

    // Update retry count in request extras
    err.requestOptions.extra['retryCount'] = retryCount + 1;

    // Wait before retrying
    await Future.delayed(Duration(seconds: delaySeconds));

    try {
      // Retry the request
      final response = await dio.fetch(err.requestOptions);
      handler.resolve(response);
    } catch (e) {
      // If retry fails, pass the error through
      if (e is DioException) {
        handler.next(e);
      } else {
        handler.next(err);
      }
    }
  }

  /// Determines if the error should trigger a retry
  bool _shouldRetry(DioException error) {
    // Don't retry on cancellation
    if (error.type == DioExceptionType.cancel) {
      return false;
    }

    // Don't retry on 4xx client errors
    if (error.response != null &&
        error.response!.statusCode != null &&
        error.response!.statusCode! < 500) {
      return false;
    }

    // Retry only on these transient errors
    return error.type == DioExceptionType.connectionError ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout;
  }

  /// Calculates exponential backoff delay in seconds
  int _calculateBackoff(int attemptNumber) {
    // attempt 0 → 1s, attempt 1 → 2s, attempt 2 → 4s
    return 1 << attemptNumber; // 2^attemptNumber
  }
}
