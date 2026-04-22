import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_stream_docs/core/ui/themes/app_sizes.dart';
import 'package:secure_stream_docs/core/utils/constants/app_constants.dart';
import 'package:secure_stream_docs/features/video_player/presentation/logic/bloc/video_player_bloc.dart';
import 'package:secure_stream_docs/features/video_player/presentation/utils/video_error_mapper.dart';
import 'package:secure_stream_docs/features/video_player/presentation/ui/widgets/video_error_widget.dart';
import 'package:secure_stream_docs/features/video_player/presentation/ui/widgets/video_player_view.dart';
import 'package:secure_stream_docs/features/video_player/presentation/ui/widgets/video_details_section.dart';
import 'video_loading_placeholder.dart';
import 'video_initial_placeholder.dart';
import 'video_empty_details.dart';

/// Area that switches based on the Bloc State
class VideoPlayerArea extends StatelessWidget {
  final VideoPlayerState state;

  const VideoPlayerArea({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return switch (state) {
      // Loading — show skeleton/loader in 16:9 container
      VideoPlayerLoading() => const VideoLoadingPlaceholder(),

      // Initial — empty placeholder with a subtle icon
      VideoPlayerInitial() => const VideoInitialPlaceholder(),

      // Error — fallback 16:9 error widget with retry
      VideoPlayerError(:final message) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VideoErrorWidget(
            errorMessage: VideoErrorMapper.getUserFriendlyError(message),
            onRetry: () => context.read<VideoPlayerBloc>().add(
              const LoadVideo(AppConstants.defaultHlsStream),
            ),
          ),
          const VideoEmptyDetails(),
        ],
      ),

      // Ready — the real player + details
      VideoPlayerReady(:final video, :final positionMs) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VideoPlayerView(video: video, initialPositionMs: positionMs),
          Padding(
            padding: EdgeInsets.only(top: AppSizses.m.sp),
            child: VideoDetailsSection(video: video),
          ),
        ],
      ),

      // CustomUrlsLoaded — keep the player visible by not re-rendering it
      // (Bloc handles URL list; we only render the player state)
      CustomUrlsLoaded() => const VideoInitialPlaceholder(),
    };
  }
}
