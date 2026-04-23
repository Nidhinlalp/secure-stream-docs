part of 'video_player_bloc.dart';

sealed class VideoPlayerState extends Equatable {
  const VideoPlayerState();

  @override
  List<Object> get props => [];
}

final class VideoPlayerInitial extends VideoPlayerState {}

final class VideoPlayerLoading extends VideoPlayerState {}

final class VideoPlayerError extends VideoPlayerState {
  final String message;

  const VideoPlayerError(this.message);

  @override
  List<Object> get props => [message];
}

final class VideoPlayerReady extends VideoPlayerState {
  final Video video;
  final int positionMs;

  const VideoPlayerReady(this.video, {this.positionMs = 0});

  @override
  List<Object> get props => [video, positionMs];
}
