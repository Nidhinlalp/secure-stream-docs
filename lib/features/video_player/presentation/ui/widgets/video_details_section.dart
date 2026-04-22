import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_stream_docs/core/ui/themes/app_sizes.dart';
import 'package:secure_stream_docs/features/video_player/domain/entities/video.dart';
import 'video_action_row.dart';

/// VideoDetailsSection
///
/// Displays video metadata (title, description) and the actions row
/// (custom URL input + download).
///
/// Accepts a [Video] domain entity directly — no raw Maps.
class VideoDetailsSection extends StatelessWidget {
  final Video video;

  const VideoDetailsSection({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSizses.l1.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSizses.height(AppSizses.l2),
          // Action row — URL input wires to Bloc internally
          const VideoActionRow(),
        ],
      ),
    );
  }
}
