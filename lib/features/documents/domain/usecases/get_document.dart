import 'package:secure_stream_docs/core/utils/types/typedef.dart';
import 'package:secure_stream_docs/features/documents/domain/entities/document.dart';
import 'package:secure_stream_docs/features/documents/domain/repositories/document_repository.dart';
import 'params.dart';

class GetDocument {
  final DocumentRepository _repository;

  GetDocument({required DocumentRepository repository})
    : _repository = repository;

  EitherFailure<Document> call(IdParams params) async {
    return _repository.getDocument(params.id);
  }
}
