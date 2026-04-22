import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:secure_stream_docs/core/utils/logger/logger.dart';

/// Structured logging interceptor for debugging network requests.
/// Only active in debug mode - does nothing in release/production.
class LoggingInterceptor extends Interceptor {
  Stopwatch? _stopwatch;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!kDebugMode) {
      handler.next(options);
      return;
    }

    _stopwatch = Stopwatch()..start();

    logger('\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    logger('[REQUEST] ${options.method} ${options.uri}');
    logger('[REQUEST] Headers: ${_maskSensitiveHeaders(options.headers)}');

    if (options.data != null) {
      logger('[REQUEST] Body: ${options.data}');
    }

    logger('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n');

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (!kDebugMode) {
      handler.next(response);
      return;
    }

    _stopwatch?.stop();
    final responseTime = _stopwatch?.elapsedMilliseconds ?? 0;

    logger('\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    logger(
      '[RESPONSE] ${response.statusCode} ${response.requestOptions.uri} (${responseTime}ms)',
    );
    logger('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n');

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (!kDebugMode) {
      handler.next(err);
      return;
    }

    _stopwatch?.stop();
    final responseTime = _stopwatch?.elapsedMilliseconds ?? 0;

    logger('\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    logger('[ERROR] ${err.type} ${err.requestOptions.uri}');

    if (err.response?.statusCode != null) {
      logger('[ERROR] Status: ${err.response!.statusCode} (${responseTime}ms)');
    } else {
      logger('[ERROR] Time: ${responseTime}ms');
    }

    logger('[ERROR] Message: ${err.message}');
    logger('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n');

    handler.next(err);
  }

  /// Masks sensitive header values to prevent logging tokens/passwords
  Map<String, dynamic> _maskSensitiveHeaders(Map<String, dynamic> headers) {
    final sensitiveKeys = {
      'authorization',
      'api-key',
      'x-api-key',
      'token',
      'x-auth-token',
      'cookie',
      'set-cookie',
    };

    return headers.map((key, value) {
      if (sensitiveKeys.contains(key.toLowerCase())) {
        return MapEntry(key, '***MASKED***');
      }
      return MapEntry(key, value);
    });
  }
}
