import 'package:flutter/material.dart';
import 'package:secure_stream_docs/core/ui/themes/app_colors.dart';

class VideoInitialPlaceholder extends StatelessWidget {
  const VideoInitialPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        color: AppColors.darkSurface,
        child: const Center(
          child: Icon(Icons.videocam_rounded, size: 64, color: Colors.white24),
        ),
      ),
    );
  }
}
