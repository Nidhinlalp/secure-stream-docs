import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:secure_stream_docs/core/ui/themes/app_colors.dart';
import 'package:secure_stream_docs/core/ui/themes/app_sizes.dart';
import 'package:secure_stream_docs/core/ui/themes/app_text_theme.dart';

class VideoErrorWidget extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetry;

  const VideoErrorWidget({
    super.key,
    required this.errorMessage,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        color: AppColors.darkSurface,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline,
                size: AppSizses.xl2.sp,
                color: AppColors.error,
              ),
              AppSizses.height(AppSizses.m),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizses.l.sp),
                child: Text(
                  errorMessage,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.bodyMedium(context)?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
              AppSizses.height(AppSizses.l1),
              OutlinedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white54),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
