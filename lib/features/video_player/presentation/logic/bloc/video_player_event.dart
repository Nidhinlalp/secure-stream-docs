part of 'video_player_bloc.dart';

sealed class VideoPlayerEvent extends Equatable {
  const VideoPlayerEvent();

  @override
  List<Object> get props => [];
}

final class LoadVideo extends VideoPlayerEvent {
  final String url;

  const LoadVideo(this.url);

  @override
  List<Object> get props => [url];
}

final class SavePlaybackPosition extends VideoPlayerEvent {
  final String url;
  final int positionMs;

  const SavePlaybackPosition({required this.url, required this.positionMs});

  @override
  List<Object> get props => [url, positionMs];
}

final class ClearPlaybackPosition extends VideoPlayerEvent {
  final String url;

  const ClearPlaybackPosition(this.url);

  @override
  List<Object> get props => [url];
}

final class AddCustomUrl extends VideoPlayerEvent {
  final String url;

  const AddCustomUrl(this.url);

  @override
  List<Object> get props => [url];
}

final class DeleteCustomUrl extends VideoPlayerEvent {
  final String url;

  const DeleteCustomUrl(this.url);

  @override
  List<Object> get props => [url];
}
