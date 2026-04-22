import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:secure_stream_docs/core/ui/themes/app_colors.dart';
import 'package:secure_stream_docs/core/ui/themes/app_sizes.dart';
import 'package:secure_stream_docs/core/ui/themes/app_text_theme.dart';
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
                borderRadius: BorderRadius.circular(AppSizses.l.sp),
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
                        width: AppSizses.xxl.sp,
                        height: AppSizses.xxl.sp,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CircularProgressIndicator(
                              value: isDownloading ? value : null,
                              strokeWidth: AppSizses.xs.sp,
                              color: AppColors.primary,
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.surfaceContainerHighest,
                            ),
                            Icon(
                              Icons.download_rounded,
                              size: AppSizses.l3.sp,
                              color: AppColors.primary,
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  AppSizses.height(AppSizses.l1),

                  // Document name
                  Text(
                    documentName,
                    style: AppTextStyle.titleSmall(context)?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  AppSizses.height(AppSizses.l),

                  // Progress bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppSizses.xs.sp),
                    child: TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0, end: progress),
                      duration: const Duration(milliseconds: 300),
                      builder: (context, value, _) {
                        return LinearProgressIndicator(
                          value: isDownloading ? value : null,
                          minHeight: AppSizses.xs1.sp,
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.surfaceContainerHighest,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.primary,
                          ),
                        );
                      },
                    ),
                  ),

                  AppSizses.height(AppSizses.m),

                  // Percentage text
                  Text(
                    isDownloading
                        ? 'Downloading… ${(progress * 100).toInt()}%'
                        : 'Preparing…',
                    style: AppTextStyle.bodySmall(context)?.copyWith(
                      color: AppColors.textSecondary(context),
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
