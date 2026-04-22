import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:secure_stream_docs/core/ui/themes/app_colors.dart';
import 'package:secure_stream_docs/core/ui/themes/app_sizes.dart';
import 'package:secure_stream_docs/core/ui/themes/app_text_theme.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSizses.xl.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.folder_open,
              size: AppSizses.xxl.sp,
              color: AppColors.textSecondary(context).withValues(alpha: 0.5),
            ),
            AppSizses.height(AppSizses.l),
            Text(
              'No documents available',
              style: AppTextStyle.titleLarge(context)?.copyWith(
                color: AppColors.textSecondary(context),
              ),
              textAlign: TextAlign.center,
            ),
            AppSizses.height(AppSizses.s),
            Text(
              'Download documents to get started',
              style: AppTextStyle.bodyMedium(context)?.copyWith(
                color: AppColors.textSecondary(context).withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
