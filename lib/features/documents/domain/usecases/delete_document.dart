import 'package:secure_stream_docs/core/utils/types/typedef.dart';
import 'package:secure_stream_docs/features/documents/domain/repositories/document_repository.dart';
import 'params.dart';

class DeleteDocument {
  final DocumentRepository _repository;

  DeleteDocument({required DocumentRepository repository})
    : _repository = repository;

  EitherUnit call(IdParams params) async {
    return _repository.deleteDocument(params.id);
  }
}
