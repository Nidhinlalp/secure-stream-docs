import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:secure_stream_docs/features/documents/domain/entities/document.dart';
import 'package:secure_stream_docs/features/documents/presentation/logic/document/documents_bloc.dart';

class DownloadProgressDialog extends StatelessWidget {
  final String documentId;
  final String documentName;

  const DownloadProgressDialog({
    super.key,
    required this.documentId,
    required this.documentName,
  });

  /// Convenience method to show the dialog and kick off the download in one call.
  static void show(BuildContext context, Document document) {
    // Fire the download event immediately so the stream starts.
    context.read<DocumentsBloc>().add(DownloadDocumentEvent(document.id));

    showDialog(
      context: context,
      barrierDismissible: false, // block outside tap
      builder: (_) {
        // Provide the same bloc instance to the dialog.
        return BlocProvider.value(
          value: context.read<DocumentsBloc>(),
          child: DownloadProgressDialog(
            documentId: document.id,
            documentName: document.name,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // Block the system back-button while downloading.
      canPop: false,
      child: BlocListener<DocumentsBloc, DocumentsState>(
        listenWhen: (prev, curr) {
          // React only when the target document's state changes.
          if (curr is DocumentsLoaded) {
            final doc = _findDocument(curr.documents);
            if (doc == null) return false;
            // Close on completion.
            return doc.isDownloaded && !doc.isDownloading;
          }
          // Close on error as well.
          return curr is DocumentsError;
        },
        listener: (context, state) {
          // Dismiss the dialog once download finishes or errors out.
          if (context.canPop()) {
            context.pop();
          }
        },
        child: BlocBuilder<DocumentsBloc, DocumentsState>(
          builder: (context, state) {
            double progress = 0;
            bool isDownloading = true;

            if (state is DocumentsLoaded) {
              final doc = _findDocument(state.documents);
              if (doc != null) {
                progress = doc.progress;
                isDownloading = doc.isDownloading;
              }
            }

            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Animated icon
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: progress),
                    duration: const Duration(milliseconds: 300),
                    builder: (context, value, _) {
                      return SizedBox(
                        width: 64,
                        height: 64,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CircularProgressIndicator(
                              value: isDownloading ? value : null,
                              strokeWidth: 4,
                              color: Theme.of(context).primaryColor,
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.surfaceContainerHighest,
                            ),
                            Icon(
                              Icons.download_rounded,
                              size: 28,
                              color: Theme.of(context).primaryColor,
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  // Document name
                  Text(
                    documentName,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 16),

                  // Progress bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0, end: progress),
                      duration: const Duration(milliseconds: 300),
                      builder: (context, value, _) {
                        return LinearProgressIndicator(
                          value: isDownloading ? value : null,
                          minHeight: 6,
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.surfaceContainerHighest,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor,
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Percentage text
                  Text(
                    isDownloading
                        ? 'Downloading… ${(progress * 100).toInt()}%'
                        : 'Preparing…',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Document? _findDocument(List<Document> documents) {
    try {
      return documents.firstWhere((d) => d.id == documentId);
    } catch (_) {
      return null;
    }
  }
}
