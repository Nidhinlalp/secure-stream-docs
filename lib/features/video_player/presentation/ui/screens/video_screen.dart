import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_stream_docs/core/ui/themes/app_sizes.dart';
import 'package:secure_stream_docs/core/utils/constants/app_constants.dart';
import 'package:secure_stream_docs/core/utils/helpers/snackbar_helper.dart';
import 'package:secure_stream_docs/features/video_player/presentation/logic/bloc/video_player_bloc.dart';
import 'package:secure_stream_docs/features/video_player/presentation/utils/video_error_mapper.dart';
import 'package:secure_stream_docs/features/video_player/presentation/ui/widgets/video_player_area.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<VideoPlayerBloc, VideoPlayerState>(
        // ── Listener: one-shot side effects (snackbars, etc.) ─────────────
        listener: (context, state) {
          if (state is VideoPlayerError) {
            SnackBarHelper.showErrorSnackBar(
              context: context,
              message: VideoErrorMapper.getUserFriendlyError(state.message),
              onRetry: () {
                context.read<VideoPlayerBloc>().add(
                  const LoadVideo(AppConstants.defaultHlsStream),
                );
              },
            );
          }
        },

        // ── Builder: rebuild on state changes ─────────────────────────────
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              // ── Video Player Area ────────────────────────────────────────
              SliverToBoxAdapter(child: VideoPlayerArea(state: state)),

              // ── Bottom Padding ───────────────────────────────────────────
              SliverToBoxAdapter(child: SizedBox(height: AppSizses.m.sp)),
            ],
          );
        },
      ),
    );
  }
}
