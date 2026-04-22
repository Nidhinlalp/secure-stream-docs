import 'package:secure_stream_docs/core/utils/types/typedef.dart';
import 'package:secure_stream_docs/features/documents/domain/repositories/document_repository.dart';
import 'params.dart';

class SaveHighlight {
  final DocumentRepository _repository;

  SaveHighlight({required DocumentRepository repository})
    : _repository = repository;

  EitherUnit call(HighlightParams params) async {
    return _repository.saveHighlight(params.docId, params.highlight);
  }
}
