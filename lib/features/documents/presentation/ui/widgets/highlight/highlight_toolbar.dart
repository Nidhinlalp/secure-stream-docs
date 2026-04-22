import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:secure_stream_docs/core/ui/themes/app_sizes.dart';

class HighlightToolbar extends StatelessWidget {
  final VoidCallback onHighlight;
  final VoidCallback onCancel;

  const HighlightToolbar({
    super.key,
    required this.onHighlight,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizses.l.sp,
        vertical: AppSizses.s1.sp,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: AppSizses.xs1,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Icon(Icons.text_fields, size: AppSizses.l3.sp),
            AppSizses.width(AppSizses.s),
            const Expanded(child: Text('Text selected')),
            TextButton.icon(
              onPressed: onCancel,
              icon: Icon(Icons.close, size: AppSizses.l3.sp),
              label: const Text('Cancel'),
            ),
            AppSizses.width(AppSizses.s),
            FilledButton.icon(
              onPressed: onHighlight,
              icon: Icon(Icons.highlight, size: AppSizses.l3.sp),
              label: const Text('Highlight'),
            ),
          ],
        ),
      ),
    );
  }
}
