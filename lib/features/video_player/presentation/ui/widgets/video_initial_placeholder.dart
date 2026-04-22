import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:secure_stream_docs/core/ui/themes/app_colors.dart';
import 'package:secure_stream_docs/core/ui/themes/app_sizes.dart';

class VideoInitialPlaceholder extends StatelessWidget {
  const VideoInitialPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        color: AppColors.darkSurface,
        child: Center(
          child: Icon(
            Icons.videocam_rounded,
            size: AppSizses.xxl.sp,
            color: Colors.white24,
          ),
        ),
      ),
    );
  }
}
