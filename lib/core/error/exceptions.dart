/// Abstract base class for all data-layer exceptions.
/// Only the data layer throws these. Repositories catch and map to Failures.
abstract class AppException implements Exception {
  final String message;

  const AppException(this.message);

  @override
  String toString() => message;
}

/// Server error from DioException (5xx response)
class ServerException extends AppException {
  const ServerException([String? message])
    : super(message ?? 'Server error occurred.');
}

/// Network error from DioException (no connection)
class NetworkException extends AppException {
  const NetworkException([String? message])
    : super(message ?? 'Network connection error.');
}

/// Timeout error from DioException
class TimeoutException extends AppException {
  const TimeoutException([String? message])
    : super(message ?? 'Request timed out.');
}

/// Authentication/authorization error from DioException (401/403)
class UnauthorizedException extends AppException {
  const UnauthorizedException([String? message])
    : super(message ?? 'Unauthorized access.');
}

/// Resource not found from DioException (404)
class NotFoundException extends AppException {
  const NotFoundException([String? message])
    : super(message ?? 'Resource not found.');
}

/// Isar database error
class CacheException extends AppException {
  const CacheException([String? message])
    : super(message ?? 'Local database error.');
}

/// File system or path error
class StorageException extends AppException {
  const StorageException([String? message])
    : super(message ?? 'Storage error occurred.');
}

/// Encryption/decryption error
class EncryptionException extends AppException {
  const EncryptionException([String? message])
    : super(message ?? 'Encryption error.');
}

/// Download stream error
class DownloadException extends AppException {
  final int? progressAtFailure;

  const DownloadException({this.progressAtFailure, String? message})
    : super(message ?? 'Download failed.');

  @override
  String toString() => message;
}

/// Catch-all for unhandled errors
class UnknownException extends AppException {
  const UnknownException([String? message])
    : super(message ?? 'An unexpected error occurred.');
}
