import 'package:flutter/material.dart';
import 'package:secure_stream_docs/core/ui/themes/app_colors.dart';

class VideoLoadingPlaceholder extends StatelessWidget {
  const VideoLoadingPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        color: AppColors.darkSurface,
        child: const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
      ),
    );
  }
}
