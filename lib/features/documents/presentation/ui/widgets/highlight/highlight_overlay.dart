import 'package:flutter/material.dart';

import 'package:secure_stream_docs/features/documents/domain/entities/highlight.dart';
import 'package:secure_stream_docs/features/documents/presentation/ui/widgets/highlight/highlight_painter.dart';

class HighlightOverlay extends StatelessWidget {
  final ValueNotifier<List<Highlight>> notifier;
  final int pageNumber;

  /// PDF page logical size in points (from [PdfPage.size]).
  final Size pageSize;

  const HighlightOverlay({
    super.key,
    required this.notifier,
    required this.pageNumber,
    required this.pageSize,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Highlight>>(
      valueListenable: notifier,
      builder: (context, highlights, _) {
        final pageHighlights = highlights
            .where((h) => h.page == pageNumber)
            .toList();

        if (pageHighlights.isEmpty) return const SizedBox.shrink();

        // IgnorePointer: critical — without this, the full-page CustomPaint
        // captures all touch events and blocks pdfrx scroll/zoom gestures.
        // RepaintBoundary: isolates repaints to this layer only.
        return IgnorePointer(
          child: RepaintBoundary(
            child: CustomPaint(
              painter: HighlightPainter(
                highlights: pageHighlights,
                pageSize: pageSize,
              ),
            ),
          ),
        );
      },
    );
  }
}
