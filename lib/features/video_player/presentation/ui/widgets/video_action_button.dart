import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_stream_docs/core/ui/themes/app_colors.dart';
import 'package:secure_stream_docs/core/ui/themes/app_sizes.dart';

class VideoActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const VideoActionButton({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Download The Current Playing Video',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppSizses.m.sp),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizses.l1.sp,
              vertical: AppSizses.m.sp,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: AppColors.primary, size: AppSizses.l2.sp),
                AppSizses.height(AppSizses.xs1),
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.textSecondary(context),
                    fontWeight: FontWeight.w500,
                    fontSize: AppSizses.m.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
