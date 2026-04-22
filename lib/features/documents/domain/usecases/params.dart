import 'package:secure_stream_docs/features/documents/domain/entities/highlight.dart';

class IdParams {
  final String id;
  const IdParams(this.id);
}

class DocIdParams {
  final String docId;
  const DocIdParams(this.docId);
}

class HighlightParams {
  final String docId;
  final Highlight highlight;

  const HighlightParams({required this.docId, required this.highlight});
}
