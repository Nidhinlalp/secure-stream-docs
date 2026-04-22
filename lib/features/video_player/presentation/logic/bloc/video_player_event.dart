part of 'video_player_bloc.dart';

sealed class VideoPlayerEvent extends Equatable {
  const VideoPlayerEvent();

  @override
  List<Object> get props => [];
}

/// Load video (initial load or new URL)
final class LoadVideo extends VideoPlayerEvent {
  final String url;

  const LoadVideo(this.url);

  @override
  List<Object> get props => [url];
}

/// Save playback position (called periodically)
final class SavePlaybackPosition extends VideoPlayerEvent {
  final String url;
  final int positionMs;

  const SavePlaybackPosition({required this.url, required this.positionMs});

  @override
  List<Object> get props => [url, positionMs];
}

/// Clear playback position (start over)
final class ClearPlaybackPosition extends VideoPlayerEvent {
  final String url;

  const ClearPlaybackPosition(this.url);

  @override
  List<Object> get props => [url];
}

/// Add custom URL (from input field)
final class AddCustomUrl extends VideoPlayerEvent {
  final String url;

  const AddCustomUrl(this.url);

  @override
  List<Object> get props => [url];
}

/// Load all custom URLs
final class LoadCustomUrls extends VideoPlayerEvent {
  const LoadCustomUrls();

  @override
  List<Object> get props => [];
}

/// Delete a custom URL
final class DeleteCustomUrl extends VideoPlayerEvent {
  final String url;

  const DeleteCustomUrl(this.url);

  @override
  List<Object> get props => [url];
}
