import 'package:secure_stream_docs/core/utils/types/typedef.dart';
import 'package:secure_stream_docs/features/documents/domain/entities/highlight.dart';
import 'package:secure_stream_docs/features/documents/domain/repositories/document_repository.dart';
import 'params.dart';

class GetHighlights {
  final DocumentRepository _repository;

  GetHighlights({required DocumentRepository repository})
    : _repository = repository;

  EitherFailure<List<Highlight>> call(DocIdParams params) async {
    return _repository.getHighlights(params.docId);
  }
}
