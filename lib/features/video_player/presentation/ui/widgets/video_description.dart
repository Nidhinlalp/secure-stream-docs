import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_stream_docs/core/ui/themes/app_colors.dart';
import 'package:secure_stream_docs/core/ui/themes/app_sizes.dart';

/// Video description widget
class VideoDescription extends StatelessWidget {
  final String? description;

  const VideoDescription({super.key, this.description});

  @override
  Widget build(BuildContext context) {
    return Text(
      description ?? 'No description available',
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: AppColors.textSecondary(context),
        height: 1.5,
        fontSize: AppSizses.l.sp,
      ),
    );
  }
}
