import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';

import 'package:secure_stream_docs/features/documents/domain/entities/highlight.dart';
import 'package:secure_stream_docs/features/documents/presentation/ui/widgets/highlight/highlight_overlay.dart';

class PdfViewerBody extends StatefulWidget {
  final String filePath;
  final bool isDownloaded;
  final PdfViewerController controller;
  final ValueNotifier<List<Highlight>> highlightsNotifier;
  final ValueNotifier<bool> isTextSelectedNotifier;
  final ValueNotifier<String?> selectedTextNotifier;

  const PdfViewerBody({
    super.key,
    required this.filePath,
    required this.isDownloaded,
    required this.controller,
    required this.highlightsNotifier,
    required this.isTextSelectedNotifier,
    required this.selectedTextNotifier,
  });

  @override
  State<PdfViewerBody> createState() => _PdfViewerBodyState();
}

class _PdfViewerBodyState extends State<PdfViewerBody> {
  late final PdfViewerParams _params;

  @override
  void initState() {
    super.initState();
    _onInit();
  }

  void _onInit() {
    _params = _buildParams();
  }

  PdfViewerParams _buildParams() {
    return PdfViewerParams(
      onePassRenderingScaleThreshold: 200 / 72,
      textSelectionParams: PdfTextSelectionParams(
        enabled: widget.isDownloaded,
        onTextSelectionChange: widget.isDownloaded
            ? _handleTextSelectionChange
            : null,
      ),

      pageOverlaysBuilder: widget.isDownloaded ? _buildPageOverlays : null,

      loadingBannerBuilder: (context, bytesDownloaded, totalBytes) =>
          const Center(child: CircularProgressIndicator()),

      errorBannerBuilder: (context, error, stackTrace, documentRef) =>
          Center(child: Text('Error loading PDF: $error')),
    );
  }

  void _handleTextSelectionChange(PdfTextSelection selection) {
    if (!selection.hasSelectedText) {
      widget.isTextSelectedNotifier.value = false;
      widget.selectedTextNotifier.value = null;
      return;
    }

    Future(() async {
      final text = await widget.controller.textSelectionDelegate
          .getSelectedText();
      final trimmed = text.trim();

      widget.selectedTextNotifier.value = trimmed.isEmpty ? null : trimmed;
      widget.isTextSelectedNotifier.value = trimmed.isNotEmpty;
    });
  }

  List<Widget> _buildPageOverlays(
    BuildContext context,
    Rect pageRect,
    PdfPage page,
  ) {
    return [
      Positioned.fill(
        child: HighlightOverlay(
          notifier: widget.highlightsNotifier,
          pageNumber: page.pageNumber,
          pageSize: page.size,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PdfViewer.file(
      widget.filePath,
      controller: widget.controller,
      params: _params,
    );
  }
}
