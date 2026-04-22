import 'package:dartz/dartz.dart';

import '../../error/error_mapper.dart';
import '../../error/failures.dart';

/// Removes try/catch boilerplate from repository implementations.
/// Every repository method calls this instead of writing try/catch manually.
Future<Either<Failure, T>> safeCall<T>(Future<T> Function() call) async {
  try {
    return Right(await call());
  } catch (e) {
    return Left(ErrorMapper.map(e));
  }
}

/// Stream variant of safeCall for reactive repository methods.
Stream<Either<Failure, T>> safeStream<T>(Stream<T> Function() call) async* {
  try {
    await for (final value in call()) {
      yield Right(value);
    }
  } catch (e) {
    yield Left(ErrorMapper.map(e));
  }
}
