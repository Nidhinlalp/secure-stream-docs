import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_stream_docs/core/ui/themes/app_colors.dart';
import 'package:secure_stream_docs/core/ui/themes/app_sizes.dart';

class VideoTitle extends StatelessWidget {
  final String? title;

  const VideoTitle({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title ?? 'Untitled Video',
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
        color: AppColors.textPrimary(context),
        fontWeight: FontWeight.w600,
        fontSize: AppSizses.l1.sp,
      ),
    );
  }
}
