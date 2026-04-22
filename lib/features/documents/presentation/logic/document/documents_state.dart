part of 'documents_bloc.dart';

sealed class DocumentsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DocumentsLoading extends DocumentsState {}

class DocumentsLoaded extends DocumentsState {
  final List<Document> documents;

  DocumentsLoaded(this.documents);

  @override
  List<Object?> get props => [documents];
}

class DocumentsError extends DocumentsState {
  final String message;

  DocumentsError(this.message);

  @override
  List<Object?> get props => [message];
}
