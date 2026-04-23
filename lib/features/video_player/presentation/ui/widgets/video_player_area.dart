import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_stream_docs/core/utils/constants/app_constants.dart';
import 'package:secure_stream_docs/core/utils/helpers/video_error_mapper.dart';
import 'package:secure_stream_docs/features/video_player/presentation/logic/bloc/video_player_bloc.dart';
import 'package:secure_stream_docs/features/video_player/presentation/ui/widgets/video_error_widget.dart';
import 'package:secure_stream_docs/features/video_player/presentation/ui/widgets/video_player_view.dart';
import 'package:secure_stream_docs/features/video_player/presentation/ui/widgets/video_details_section.dart';
import 'video_loading_placeholder.dart';
import 'video_initial_placeholder.dart';

class VideoPlayerArea extends StatelessWidget {
  final VideoPlayerState state;

  const VideoPlayerArea({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return switch (state) {
      // Loading
      VideoPlayerLoading() => const VideoLoadingPlaceholder(),

      // Initial
      VideoPlayerInitial() => const VideoInitialPlaceholder(),

      // Error
      VideoPlayerError(:final message) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VideoErrorWidget(
            errorMessage: VideoErrorMapper.getUserFriendlyError(message),
            onRetry: () => context.read<VideoPlayerBloc>().add(
              const LoadVideo(AppConstants.defaultHlsStream),
            ),
          ),
          const VideoDetailsSection(),
        ],
      ),

      // Ready
      VideoPlayerReady(:final video, :final positionMs) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VideoPlayerView(video: video, initialPositionMs: positionMs),
          const VideoDetailsSection(),
        ],
      ),
    };
  }
}
