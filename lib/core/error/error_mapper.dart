import 'dart:io';

import 'package:dio/dio.dart';
import 'package:isar_community/isar.dart';
import 'package:secure_stream_docs/core/error/exceptions.dart';
import 'package:secure_stream_docs/core/error/failures.dart';

/// Maps exceptions to domain-level failures.
/// Repository implementations call this instead of writing switch/if chains.
class ErrorMapper {
  ErrorMapper._();

  /// Maps any exception to its corresponding Failure.
  /// Never throws, always returns a Failure.
  static Failure map(Object exception) {
    // Map AppException subclasses
    if (exception is AppException) {
      return _mapAppException(exception);
    }

    // Map DioException by type
    if (exception is DioException) {
      return _mapDioException(exception);
    }

    // Map Isar errors
    if (exception is IsarError) {
      return CacheFailure(exception.message);
    }

    // Map path/file errors
    if (exception is PathNotFoundException) {
      return StorageFailure('File not found: ${exception.message}');
    }

    // Map format errors
    if (exception is FormatException) {
      return UnknownFailure('Format error: ${exception.message}');
    }

    // Default catch-all
    return UnknownFailure(exception.toString());
  }

  /// Maps AppException subclasses to corresponding Failure subclasses
  static Failure _mapAppException(AppException exception) {
    switch (exception.runtimeType) {
      case const (ServerException):
        return ServerFailure(exception.message);
      case const (NetworkException):
        return NetworkFailure(exception.message);
      case const (TimeoutException):
        return TimeoutFailure(exception.message);
      case const (UnauthorizedException):
        return UnauthorizedFailure(exception.message);
      case const (NotFoundException):
        return NotFoundFailure(exception.message);
      case const (CacheException):
        return CacheFailure(exception.message);
      case const (StorageException):
        return StorageFailure(exception.message);
      case const (EncryptionException):
        return EncryptionFailure(exception.message);
      case const (DownloadException):
        return DownloadFailure(
          progress: (exception as DownloadException).progressAtFailure,
          message: exception.message,
        );
      case const (UnknownException):
        return UnknownFailure(exception.message);
      default:
        return UnknownFailure(exception.message);
    }
  }

  /// Maps DioException to Failure based on exception type
  static Failure _mapDioException(DioException exception) {
    // Check for HTTP status codes first
    if (exception.response != null) {
      final statusCode = exception.response!.statusCode;
      if (statusCode != null) {
        if (statusCode >= 500) {
          return ServerFailure('Server error: $statusCode');
        }
        if (statusCode == 401 || statusCode == 403) {
          return UnauthorizedFailure('Authentication failed: $statusCode');
        }
        if (statusCode == 404) {
          return NotFoundFailure('Resource not found: $statusCode');
        }
        if (statusCode >= 400) {
          return UnknownFailure('Client error: $statusCode');
        }
      }
    }

    // Map by DioExceptionType
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return TimeoutFailure(exception.message);
      case DioExceptionType.connectionError:
        return NetworkFailure(exception.message);
      case DioExceptionType.badResponse:
        final statusCode = exception.response?.statusCode;
        if (statusCode != null && statusCode >= 500) {
          return ServerFailure('Server error: $statusCode');
        }
        return UnknownFailure('Bad response: ${exception.message}');
      case DioExceptionType.cancel:
        return UnknownFailure('Request cancelled');
      case DioExceptionType.unknown:
        return UnknownFailure(exception.message ?? 'Unknown error occurred');
      default:
        return UnknownFailure(exception.message ?? 'Unexpected error');
    }
  }
}
