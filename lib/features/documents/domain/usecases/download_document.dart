import 'package:secure_stream_docs/core/utils/types/typedef.dart';
import 'package:secure_stream_docs/features/documents/domain/entities/document.dart';
import 'package:secure_stream_docs/features/documents/domain/repositories/document_repository.dart';
import 'params.dart';

class DownloadDocument {
  final DocumentRepository _repository;

  DownloadDocument({required DocumentRepository repository})
    : _repository = repository;

  EitherStream<Document> call(IdParams params) {
    return _repository.downloadDocument(params.id);
  }
}
