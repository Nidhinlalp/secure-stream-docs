import 'package:isar_community/isar.dart';
import 'dart:ui';

import 'package:secure_stream_docs/features/documents/domain/entities/highlight.dart';

part 'highlight_model.g.dart';

@collection
class HighlightModel {
  Id id = Isar.autoIncrement;

  late String highlightId;
  late String docId;
  late int page;
  late String text;

  // Stored in PDF point coordinate space:
  //   left / right  → X axis (same direction as screen)
  //   top           → stores pdfBottom (smaller value, b.bottom from PdfRect)
  //   bottom        → stores pdfTop    (larger value,  b.top   from PdfRect)
  // The painter applies the Y-flip using page.size.height.
  late double left;
  late double top;
  late double right;
  late double bottom;

  /// ARGB color int — nullable for backward compat with existing records.
  int? colorValue;

  late DateTime createdAt;

  Highlight toEntity() {
    return Highlight(
      id: highlightId,
      docId: docId,
      page: page,
      text: text,
      position: Rect.fromLTRB(left, top, right, bottom),
      colorValue: colorValue ?? 0x80FFEB3B,
      createdAt: createdAt,
    );
  }

  static HighlightModel fromEntity(Highlight h) {
    return HighlightModel()
      ..highlightId = h.id
      ..docId = h.docId
      ..page = h.page
      ..text = h.text
      ..left = h.position.left
      ..top = h.position.top
      ..right = h.position.right
      ..bottom = h.position.bottom
      ..colorValue = h.colorValue
      ..createdAt = h.createdAt;
  }
}
