import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

import 'package:secure_stream_docs/features/documents/domain/entities/highlight.dart';

/// Paints highlight rectangles on top of a PDF page.
///
/// Coordinate mapping:
///   Stored [Highlight.position] uses [Rect.fromLTRB] with these semantics:
///     position.left   = PDF left  (x, same direction as screen)
///     position.top    = PDF bottom (smaller Y in PDF — Y-axis points UP in PDF)
///     position.right  = PDF right
///     position.bottom = PDF top   (larger Y in PDF)
///
///   Screen conversion (Flutter canvas, Y-axis points DOWN):
///     screenLeft   =  pdfLeft               * scaleX
///     screenTop    = (pageH − pdfTop)        * scaleY
///     screenRight  =  pdfRight              * scaleX
///     screenBottom = (pageH − pdfBottom)    * scaleY
class HighlightPainter extends CustomPainter {
  final List<Highlight> highlights;

  /// PDF page logical size in points (from [PdfPage.size]).
  final Size pageSize;

  const HighlightPainter({
    required this.highlights,
    required this.pageSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (highlights.isEmpty) return;

    final scaleX = pageSize.width > 0 ? size.width / pageSize.width : 1.0;
    final scaleY = pageSize.height > 0 ? size.height / pageSize.height : 1.0;
    final pageH = pageSize.height;

    for (final h in highlights) {
      final paint = Paint()
        ..color = h.color.withValues(alpha: 0.45)
        ..style = PaintingStyle.fill;

      if (h.position == Rect.zero) {
        // Fallback strip — visible but non-obtrusive.
        canvas.drawRect(
          Rect.fromLTWH(0, size.height * 0.1, size.width, 10),
          paint,
        );
        continue;
      }

      // Extract the stored PDF-space values.
      // Recall: position = Rect.fromLTRB(pdfLeft, pdfBottom, pdfRight, pdfTop)
      final pdfLeft   = h.position.left;
      final pdfBottom = h.position.top;    // stored in Flutter 'top' slot
      final pdfRight  = h.position.right;
      final pdfTop    = h.position.bottom; // stored in Flutter 'bottom' slot

      final screenLeft   = pdfLeft   * scaleX;
      final screenTop    = (pageH - pdfTop)    * scaleY;
      final screenRight  = pdfRight  * scaleX;
      final screenBottom = (pageH - pdfBottom) * scaleY;

      canvas.drawRect(
        Rect.fromLTRB(screenLeft, screenTop, screenRight, screenBottom),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant HighlightPainter old) =>
      !listEquals(old.highlights, highlights) || old.pageSize != pageSize;
}
