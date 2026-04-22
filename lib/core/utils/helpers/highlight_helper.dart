import 'package:secure_stream_docs/features/documents/domain/entities/highlight.dart';

class HighlightHelper {
  HighlightHelper._();

  /// Groups a flat list of [Highlight]s by their page number.
  ///
  /// Each page's highlights are sorted chronologically by [Highlight.createdAt].
  static Map<int, List<Highlight>> groupByPage(List<Highlight> highlights) {
    final map = <int, List<Highlight>>{};

    for (final h in highlights) {
      map.putIfAbsent(h.page, () => []).add(h);
    }

    for (final list in map.values) {
      list.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    }

    return map;
  }
}
