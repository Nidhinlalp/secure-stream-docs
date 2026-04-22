import 'package:dartz/dartz.dart';
import 'package:secure_stream_docs/core/error/failures.dart';

/// Shared type aliases used across all features to keep return types readable.

/// Represents any operation that can fail with a Failure
typedef EitherFailure<T> = Future<Either<Failure, T>>;

/// Represents a void operation that can fail with a Failure
typedef EitherUnit = Future<Either<Failure, Unit>>;

/// Represents a list operation that can fail with a Failure
typedef EitherList<T> = Future<Either<Failure, List<T>>>;

/// Represents a stream operation that can fail with a Failure
typedef EitherStream<T> = Stream<Either<Failure, T>>;
