import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:secure_stream_docs/core/ui/themes/app_sizes.dart';

class DownloadButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const DownloadButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.download),
      label: const Text('Download'),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizses.l.sp,
          vertical: AppSizses.s.sp,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizses.s.sp),
        ),
      ),
    );
  }
}
