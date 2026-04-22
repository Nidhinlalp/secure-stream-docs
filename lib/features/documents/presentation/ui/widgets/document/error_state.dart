import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:secure_stream_docs/core/ui/themes/app_colors.dart';
import 'package:secure_stream_docs/core/ui/themes/app_sizes.dart';
import 'package:secure_stream_docs/core/ui/themes/app_text_theme.dart';

class ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorState({super.key, required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSizses.xl.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: AppSizses.xxl.sp,
              color: AppColors.error,
            ),
            AppSizses.height(AppSizses.l),
            Text(
              'Something went wrong',
              style: AppTextStyle.titleLarge(context)?.copyWith(
                color: AppColors.error,
              ),
              textAlign: TextAlign.center,
            ),
            AppSizses.height(AppSizses.s),
            Text(
              message,
              style: AppTextStyle.bodyMedium(context)?.copyWith(
                color: AppColors.textSecondary(context),
              ),
              textAlign: TextAlign.center,
            ),
            AppSizses.height(AppSizses.l2),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizses.l2.sp,
                  vertical: AppSizses.m.sp,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizses.s.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
