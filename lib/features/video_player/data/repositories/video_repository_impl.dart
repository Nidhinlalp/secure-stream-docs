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

  @override
  EitherFailure<Video> getOrCreateVideo(String url) async {
    try {
      final model = await _localDataSource.getOrCreateVideo(url);
      return Right(model.toEntity());
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  EitherUnit updatePlaybackPosition(String url, int positionMs) async {
    try {
      await _localDataSource.updatePlaybackPosition(url, positionMs);
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  EitherFailure<int> getLastPosition(String url) async {
    try {
      final position = await _localDataSource.getLastPosition(url);
      return Right(position);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  EitherUnit clearPlaybackPosition(String url) async {
    try {
      await _localDataSource.clearPlaybackPosition(url);
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  EitherUnit saveCustomUrl(String url) async {
    try {
      await _localDataSource.saveCustomUrl(url);
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  EitherList<String> getCustomUrls() async {
    try {
      final urls = await _localDataSource.getCustomUrls();
      return Right(urls);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

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
