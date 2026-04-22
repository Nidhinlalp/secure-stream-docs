import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:uuid/uuid.dart';

import 'package:secure_stream_docs/core/ui/themes/app_colors.dart';
import 'package:secure_stream_docs/core/ui/themes/app_sizes.dart';
import 'package:secure_stream_docs/core/ui/themes/app_text_theme.dart';
import 'package:secure_stream_docs/features/documents/domain/entities/highlight.dart';
import 'package:secure_stream_docs/features/documents/presentation/logic/highlight/highlight_cubit.dart';
import 'package:secure_stream_docs/features/documents/presentation/logic/viewer/viewer_cubit.dart';
import 'package:secure_stream_docs/features/documents/presentation/router/document_routes.dart';
import 'package:secure_stream_docs/features/documents/presentation/ui/widgets/highlight/highlight_toolbar.dart';
import 'package:secure_stream_docs/features/documents/presentation/ui/widgets/pdf_view/pdf_viewer_body.dart';

class PdfViewerScreen extends StatefulWidget {
  final String pdfId;

  const PdfViewerScreen({super.key, required this.pdfId});

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  // pdf controller
  final _pdfController = PdfViewerController();

  /// Source of truth for rendered highlights.
  /// Updated by [HighlightCubit] listener AND optimistically on save.
  final _highlightsNotifier = ValueNotifier<List<Highlight>>([]);

  /// Drives toolbar visibility without rebuilding [PdfViewer].
  final _isTextSelectedNotifier = ValueNotifier<bool>(false);

  /// Holds the current selected text string.
  final _selectedTextNotifier = ValueNotifier<String?>(null);

  /// Path of the decrypted temp file — deleted in [dispose].
  String? _tempFilePath;

  @override
  void initState() {
    super.initState();
    _onInit();
  }

  void _onInit() {
    context.read<ViewerCubit>().openDocument(widget.pdfId);
    context.read<HighlightCubit>().load(widget.pdfId);
  }

  @override
  void dispose() {
    _deleteTempFile();
    _highlightsNotifier.dispose();
    _isTextSelectedNotifier.dispose();
    _selectedTextNotifier.dispose();
    super.dispose();
  }

  void _deleteTempFile() {
    final path = _tempFilePath;
    if (path == null) return;
    File(path).exists().then((exists) {
      if (exists) File(path).delete();
    });
  }

  void _retry() {
    context.read<ViewerCubit>().openDocument(widget.pdfId);
    context.read<HighlightCubit>().load(widget.pdfId);
  }

  void _cancelSelection() {
    unawaited(_pdfController.textSelectionDelegate.clearTextSelection());
    _isTextSelectedNotifier.value = false;
    _selectedTextNotifier.value = null;
  }

  Future<Rect> _captureSelectionRect() async {
    try {
      final ranges = await _pdfController.textSelectionDelegate
          .getSelectedTextRanges();
      if (ranges.isEmpty) return Rect.zero;

      final b = ranges.first.bounds;
      if (b.isEmpty) return Rect.zero;

      return Rect.fromLTRB(b.left, b.bottom, b.right, b.top);
    } catch (_) {
      return Rect.zero;
    }
  }

  Future<void> _onSaveHighlight() async {
    final text = _selectedTextNotifier.value;
    if (text == null || text.isEmpty) return;

    final color = await _pickColor();
    if (color == null || !mounted) return;

    // Capture rect BEFORE clearing selection.
    final rect = await _captureSelectionRect();

    // Clear selection immediately — fire-and-forget.
    _cancelSelection();

    if (!mounted) return;

    final highlight = Highlight(
      id: const Uuid().v4(),
      docId: widget.pdfId,
      page: _pdfController.pageNumber ?? 1,
      text: text,
      position: rect,
      colorValue: color.toARGB32(),
      createdAt: DateTime.now(),
    );

    _highlightsNotifier.value = [..._highlightsNotifier.value, highlight];

    // Fire-and-forget DB write — don't block the UI thread.
    // The BlocListener will sync the notifier when the cubit emits
    // HighlightLoaded, but the user already sees the highlight above.
    unawaited(context.read<HighlightCubit>().add(widget.pdfId, highlight));

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Highlight saved')));
  }

  Future<Color?> _pickColor() {
    final colors = [
      const Color(0x80FFEB3B), // yellow
      const Color(0x8066BB6A), // green
      const Color(0x8042A5F5), // blue
      const Color(0x80EF5350), // red
      const Color(0x80FFA726), // orange
    ];

    return showDialog<Color>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Pick highlight colour'),
        content: Wrap(
          spacing: AppSizses.s1,
          runSpacing: AppSizses.s1,
          children: colors
              .map(
                (c) => GestureDetector(
                  onTap: () => Navigator.pop(ctx, c),
                  child: Container(
                    width: AppSizses.xl1.sp,
                    height: AppSizses.xl1.sp,
                    decoration: BoxDecoration(
                      color: c,
                      border: Border.all(
                        color: AppColors.textSecondary(context),
                      ),
                      borderRadius: BorderRadius.circular(AppSizses.s.sp),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        // Cache temp file path; no UI rebuild needed.
        BlocListener<ViewerCubit, ViewerState>(
          listener: (_, state) {
            if (state is ViewerLoaded) _tempFilePath = state.path;
          },
        ),
        // Sync highlights from DB into the notifier.
        BlocListener<HighlightCubit, HighlightState>(
          listener: (_, state) {
            if (state is HighlightLoaded) {
              _highlightsNotifier.value = state.highlights;
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('PDF Viewer'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.format_list_bulleted),
              tooltip: 'View Highlights',
              onPressed: () =>
                  HighlightsReviewRoute(documentId: widget.pdfId).push(context),
            ),
          ],
        ),
        body: BlocBuilder<ViewerCubit, ViewerState>(
          builder: (context, state) {
            if (state is ViewerLoading) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(),
                    AppSizses.height(AppSizses.l),
                    Text(
                      'Decrypting document…',
                      style: AppTextStyle.bodyMedium(context),
                    ),
                  ],
                ),
              );
            }
            if (state is ViewerError) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(AppSizses.l2.sp),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: AppSizses.xl2.sp,
                        color: AppColors.error,
                      ),
                      AppSizses.height(AppSizses.l),
                      Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: AppTextStyle.titleMedium(context),
                      ),
                      AppSizses.height(AppSizses.l2),
                      ElevatedButton.icon(
                        onPressed: _retry,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              );
            }
            if (state is ViewerLoaded) return _buildViewerLayout(state);
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildViewerLayout(ViewerLoaded state) {
    final isDownloaded = state.document.isDownloaded;

    return Column(
      children: [
        // PdfViewerBody
        Expanded(
          child: PdfViewerBody(
            filePath: state.path,
            isDownloaded: isDownloaded,
            controller: _pdfController,
            highlightsNotifier: _highlightsNotifier,
            isTextSelectedNotifier: _isTextSelectedNotifier,
            selectedTextNotifier: _selectedTextNotifier,
          ),
        ),

        if (isDownloaded)
          ValueListenableBuilder<bool>(
            valueListenable: _isTextSelectedNotifier,
            builder: (_, isSelected, _) {
              if (!isSelected) {
                return const SizedBox.shrink();
              }
              return HighlightToolbar(
                onHighlight: _onSaveHighlight,
                onCancel: _cancelSelection,
              );
            },
          ),
      ],
    );
  }
}
