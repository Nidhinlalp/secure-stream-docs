part of 'video_player_bloc.dart';

sealed class VideoPlayerState extends Equatable {
  const VideoPlayerState();

  @override
  List<Object> get props => [];
}

/// Initial state
final class VideoPlayerInitial extends VideoPlayerState {}

/// Loading state
final class VideoPlayerLoading extends VideoPlayerState {}

// Error state
final class VideoPlayerError extends VideoPlayerState {
  final String message;

  const VideoPlayerError(this.message);

  @override
  List<Object> get props => [message];
}

// Ready state
final class VideoPlayerReady extends VideoPlayerState {
  final Video video;
  final int positionMs;

  const VideoPlayerReady(this.video, {this.positionMs = 0});

  @override
  List<Object> get props => [video, positionMs];
}

/// Custom URLs loaded state
final class CustomUrlsLoaded extends VideoPlayerState {
  final List<String> urls;

  const CustomUrlsLoaded(this.urls);

  @override
  List<Object> get props => [urls];
}
