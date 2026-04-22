import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:secure_stream_docs/core/ui/themes/app_colors.dart';
import 'package:secure_stream_docs/core/ui/themes/app_sizes.dart';
import 'package:secure_stream_docs/core/ui/themes/app_text_theme.dart';
import 'package:secure_stream_docs/features/documents/domain/entities/highlight.dart';
import 'package:secure_stream_docs/features/documents/presentation/ui/widgets/highlight/highlight_card.dart';

class HighlightPageSection extends StatelessWidget {
  final int pageNumber;
  final List<Highlight> highlights;

  const HighlightPageSection({
    super.key,
    required this.pageNumber,
    required this.highlights,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Page header
        Padding(
          padding: EdgeInsets.symmetric(vertical: AppSizses.s.sp),
          child: Row(
            children: [
              Icon(
                Icons.description_outlined,
                size: AppSizses.l1.sp,
                color: AppColors.primary,
              ),
              AppSizses.width(AppSizses.s),
              Text(
                'Page $pageNumber',
                style: AppTextStyle.titleSmall(context)?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              AppSizses.width(AppSizses.s),
              Text(
                '(${highlights.length} highlight${highlights.length > 1 ? 's' : ''})',
                style: AppTextStyle.bodySmall(context)?.copyWith(
                  color: AppColors.textSecondary(context),
                ),
              ),
            ],
          ),
        ),

        // Highlight cards
        ...highlights.map(
          (h) => HighlightCard(highlight: h),
        ),

        AppSizses.height(AppSizses.l),
      ],
    );
  }
}
