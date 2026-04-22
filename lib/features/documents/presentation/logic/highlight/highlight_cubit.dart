import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:secure_stream_docs/features/documents/domain/entities/highlight.dart';
import 'package:secure_stream_docs/features/documents/domain/usecases/get_highlights.dart';
import 'package:secure_stream_docs/features/documents/domain/usecases/params.dart';
import 'package:secure_stream_docs/features/documents/domain/usecases/save_highlight.dart';

part 'highlight_state.dart';

class HighlightCubit extends Cubit<HighlightState> {
  final GetHighlights _getHighlights;
  final SaveHighlight _saveHighlight;

  HighlightCubit({
    required GetHighlights getHighlights,
    required SaveHighlight saveHighlight,
  }) : _getHighlights = getHighlights,
       _saveHighlight = saveHighlight,
       super(HighlightInitial());

  // ─────────────────────────────────────────────────────
  // Load all highlights for a document from local storage
  // ─────────────────────────────────────────────────────
  Future<void> load(String docId) async {
    emit(HighlightLoading());

    final result = await _getHighlights(DocIdParams(docId));

    result.fold(
      (f) => emit(HighlightError(f.message)),
      (list) => emit(HighlightLoaded(list)),
    );
  }

  // ─────────────────────────────────────────────────────
  // Save a highlight to local storage
  // ─────────────────────────────────────────────────────
  Future<void> add(String docId, Highlight highlight) async {
    await _saveHighlight(HighlightParams(docId: docId, highlight: highlight));

    await load(docId);
  }
}
