import 'package:equatable/equatable.dart';

/// Abstract base class for all domain-level failures.
/// Used by repositories and use cases to return errors in a type-safe way.
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

/// No internet connection or socket error
class NetworkFailure extends Failure {
  const NetworkFailure([String? message])
    : super(
        message ?? 'A network error occurred. Please check your connection.',
      );
}

/// HTTP 5xx server errors
class ServerFailure extends Failure {
  const ServerFailure([String? message])
    : super(message ?? 'Server error occurred. Please try again later.');
}

/// HTTP 401/403 authentication/authorization errors
class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure([String? message])
    : super(message ?? 'Authentication failed. Please login again.');
}

/// HTTP 404 resource not found
class NotFoundFailure extends Failure {
  const NotFoundFailure([String? message])
    : super(message ?? 'The requested resource was not found.');
}

/// Connection or receive timeout
class TimeoutFailure extends Failure {
  const TimeoutFailure([String? message])
    : super(message ?? 'Request timed out. Please try again.');
}

/// Isar database read/write errors
class CacheFailure extends Failure {
  const CacheFailure([String? message])
    : super(message ?? 'Local database error occurred.');
}

/// File system or path errors
class StorageFailure extends Failure {
  const StorageFailure([String? message])
    : super(message ?? 'Storage error occurred. Please check available space.');
}

/// Encryption/decryption errors
class EncryptionFailure extends Failure {
  const EncryptionFailure([String? message])
    : super(message ?? 'Encryption error occurred.');
}

/// Dio download stream errors
class DownloadFailure extends Failure {
  final int? progress;

  const DownloadFailure({this.progress, String? message})
    : super(message ?? 'Download failed. Please try again.');

  @override
  List<Object?> get props => [message, progress];
}

/// Catch-all for unhandled errors
class UnknownFailure extends Failure {
  const UnknownFailure([String? message])
    : super(message ?? 'An unexpected error occurred. Please try again later.');
}
