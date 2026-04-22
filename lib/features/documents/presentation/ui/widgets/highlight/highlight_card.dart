import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:secure_stream_docs/core/ui/themes/app_colors.dart';
import 'package:secure_stream_docs/core/ui/themes/app_sizes.dart';
import 'package:secure_stream_docs/core/ui/themes/app_text_theme.dart';
import 'package:secure_stream_docs/core/utils/helpers/date_format_helper.dart';
import 'package:secure_stream_docs/features/documents/domain/entities/highlight.dart';

class HighlightCard extends StatelessWidget {
  final Highlight highlight;

  const HighlightCard({super.key, required this.highlight});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormatHelper.formatDateTime(highlight.createdAt);

    return Card(
      elevation: 1,
      margin: EdgeInsets.symmetric(vertical: AppSizses.xs.sp),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizses.s1.sp),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppSizses.m.sp),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Colour swatch
            Container(
              width: AppSizses.xs1.sp,
              height: AppSizses.xl2.sp,
              decoration: BoxDecoration(
                color: highlight.color,
                borderRadius: BorderRadius.circular(AppSizses.px1.sp + 1),
              ),
            ),
            AppSizses.width(AppSizses.m),

            // Text + timestamp
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    highlight.text,
                    style: AppTextStyle.bodyMedium(context)?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                  AppSizses.height(AppSizses.xs1),
                  Text(
                    formattedDate,
                    style: AppTextStyle.bodySmall(context)?.copyWith(
                      color: AppColors.textSecondary(context),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
