import 'package:secure_stream_docs/core/utils/types/typedef.dart';
import 'package:secure_stream_docs/features/documents/domain/entities/document.dart';
import 'package:secure_stream_docs/features/documents/domain/repositories/document_repository.dart';

class GetDocuments {
  final DocumentRepository _repository;

  GetDocuments({required DocumentRepository repository})
    : _repository = repository;

  EitherFailure<List<Document>> call() async {
    return _repository.getDocuments();
  }
}
