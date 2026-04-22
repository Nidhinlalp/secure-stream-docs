import 'package:dartz/dartz.dart';
import 'package:isar_community/isar.dart';

import '../error/error_mapper.dart';
import '../error/failures.dart';

/// Safe wrapper around Isar database operations.
/// All features use this, never open Isar directly.
class LocalStorageClient {
  final Isar _isar;

  LocalStorageClient({required Isar isar}) : _isar = isar;

  /// Generic write method with error handling.
  /// Wraps any Isar write operation in try/catch and maps errors to CacheFailure.
  Future<Either<CacheFailure, T>> write<T>(
    Future<T> Function(Isar) operation,
  ) async {
    try {
      final result = await operation(_isar);
      return Right(result);
    } catch (e) {
      return Left(ErrorMapper.map(e) as CacheFailure);
    }
  }

  /// Generic read method with error handling.
  /// Wraps any Isar read operation in try/catch and maps errors to CacheFailure.
  Future<Either<CacheFailure, T>> read<T>(
    Future<T> Function(Isar) operation,
  ) async {
    try {
      final result = await operation(_isar);
      return Right(result);
    } catch (e) {
      return Left(ErrorMapper.map(e) as CacheFailure);
    }
  }

  /// Generic delete method with error handling.
  /// Wraps any Isar delete operation in try/catch and maps errors to CacheFailure.
  Future<Either<CacheFailure, Unit>> delete(
    Future<void> Function(Isar) operation,
  ) async {
    try {
      await operation(_isar);
      return const Right(unit);
    } catch (e) {
      return Left(ErrorMapper.map(e) as CacheFailure);
    }
  }

  /// Stream method with error handling.
  /// Wraps any Isar watch operation and maps stream errors to CacheFailure.
  Stream<Either<CacheFailure, T>> watch<T>(
    Stream<T> Function(Isar) operation,
  ) async* {
    try {
      final stream = operation(_isar);
      await for (final value in stream) {
        yield Right(value);
      }
    } catch (e) {
      yield Left(ErrorMapper.map(e) as CacheFailure);
    }
  }

  /// Returns the underlying Isar instance for advanced operations.
  /// Use with caution - prefer the safe methods above.
  Isar get isar => _isar;
}
