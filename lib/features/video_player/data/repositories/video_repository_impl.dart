import 'package:dartz/dartz.dart';
import 'package:secure_stream_docs/core/error/failures.dart';
import 'package:secure_stream_docs/core/utils/types/typedef.dart';
import 'package:secure_stream_docs/features/video_player/data/datasource/local/local_video_data_source.dart';
import 'package:secure_stream_docs/features/video_player/domain/entities/video.dart';
import 'package:secure_stream_docs/features/video_player/domain/repositories/video_repository.dart';

class VideoRepositoryImpl implements VideoRepository {
  final LocalVideoDataSource _localDataSource;

  VideoRepositoryImpl({required LocalVideoDataSource localDataSource})
    : _localDataSource = localDataSource;

  // ─────────────────────────────────────────────────────────────────────────
  /// Get or create video entity
  // ─────────────────────────────────────────────────────────────────────────
  @override
  EitherFailure<Video> getOrCreateVideo(String url) async {
    try {
      final model = await _localDataSource.getOrCreateVideo(url);
      return Right(model.toEntity());
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  /// Update playback position
  // ─────────────────────────────────────────────────────────────────────────
  @override
  EitherUnit updatePlaybackPosition(String url, int positionMs) async {
    try {
      await _localDataSource.updatePlaybackPosition(url, positionMs);
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  /// Get last playback position
  // ─────────────────────────────────────────────────────────────────────────
  @override
  EitherFailure<int> getLastPosition(String url) async {
    try {
      final position = await _localDataSource.getLastPosition(url);
      return Right(position);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  /// Clear playback position
  // ─────────────────────────────────────────────────────────────────────────
  @override
  EitherUnit clearPlaybackPosition(String url) async {
    try {
      await _localDataSource.clearPlaybackPosition(url);
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  /// Save custom URL
  // ─────────────────────────────────────────────────────────────────────────
  @override
  EitherUnit saveCustomUrl(String url) async {
    try {
      await _localDataSource.saveCustomUrl(url);
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  /// Delete custom URL
  // ─────────────────────────────────────────────────────────────────────────
  @override
  EitherUnit deleteCustomUrl(String url) async {
    try {
      await _localDataSource.deleteCustomUrl(url);
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
