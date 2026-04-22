import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_stream_docs/core/ui/themes/app_sizes.dart';
import 'video_action_row.dart';

class VideoDetailsSection extends StatelessWidget {
  const VideoDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSizses.l1.sp),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [VideoActionRow()],
      ),
    );
  }
}
