import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:secure_stream_docs/features/documents/domain/entities/document.dart';
import 'package:secure_stream_docs/features/documents/domain/usecases/get_document.dart';
import 'package:secure_stream_docs/features/documents/domain/usecases/params.dart';

part 'viewer_state.dart';

class ViewerCubit extends Cubit<ViewerState> {
  final GetDocument _getDocument;

  ViewerCubit({required GetDocument getDocument})
    : _getDocument = getDocument,
      super(ViewerInitial());

  // ─────────────────────────────────────────────────────
  // decrypt the PDF document from local storage and Open
  // ─────────────────────────────────────────────────────
  Future<void> openDocument(String id) async {
    emit(ViewerLoading());

    final result = await _getDocument(IdParams(id));

    result.fold((failure) => emit(ViewerError(failure.message)), (document) {
      if (document.localPath != null && document.localPath!.isNotEmpty) {
        emit(ViewerLoaded(path: document.localPath!, document: document));
      } else {
        emit(ViewerError('Document path is empty'));
      }
    });
  }
}
