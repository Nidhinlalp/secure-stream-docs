import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_stream_docs/core/ui/themes/app_sizes.dart';

class VideoEmptyDetails extends StatelessWidget {
  const VideoEmptyDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSizses.l1.sp),
      child: const SizedBox.shrink(),
    );
  }
}
