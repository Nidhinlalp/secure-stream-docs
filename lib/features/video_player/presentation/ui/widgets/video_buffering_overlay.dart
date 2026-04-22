import 'package:flutter/material.dart';

import 'package:secure_stream_docs/core/ui/themes/app_sizes.dart';
import 'package:secure_stream_docs/core/ui/themes/app_text_theme.dart';

class VideoBufferingOverlay extends StatelessWidget {
  final bool isBuffering;

  const VideoBufferingOverlay({super.key, required this.isBuffering});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        ignoring: !isBuffering,
        child: AnimatedOpacity(
          opacity: isBuffering ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),
          child: Container(
            color: Colors.black.withValues(alpha: 0.3),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(color: Colors.white),
                  AppSizses.height(AppSizses.m),
                  Text(
                    'Buffering...',
                    style: AppTextStyle.bodySmall(context)?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
