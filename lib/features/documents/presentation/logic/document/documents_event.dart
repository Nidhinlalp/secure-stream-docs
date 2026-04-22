part of 'documents_bloc.dart';

sealed class DocumentsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadDocuments extends DocumentsEvent {}

class DownloadDocumentEvent extends DocumentsEvent {
  final String id;
  DownloadDocumentEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class DeleteDocumentEvent extends DocumentsEvent {
  final String id;
  DeleteDocumentEvent(this.id);

  @override
  List<Object?> get props => [id];
}
