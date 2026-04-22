import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:secure_stream_docs/core/ui/themes/app_sizes.dart';
import 'package:secure_stream_docs/core/utils/helpers/snackbar_helper.dart';
import 'package:secure_stream_docs/features/documents/domain/entities/document.dart';
import 'package:secure_stream_docs/features/documents/presentation/ui/widgets/document/document_card.dart';
import 'package:secure_stream_docs/features/documents/presentation/ui/widgets/document/download_progress_dialog.dart';
import 'package:secure_stream_docs/features/documents/presentation/logic/document/documents_bloc.dart';
import 'package:secure_stream_docs/features/documents/presentation/router/document_routes.dart';
import 'package:secure_stream_docs/core/utils/helpers/confirmation_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DocumentList extends StatelessWidget {
  final List<Document> documents;

  const DocumentList({super.key, required this.documents});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<DocumentsBloc>().add(LoadDocuments());
      },
      child: ListView.separated(
        padding: EdgeInsets.all(AppSizses.l.sp),
        itemCount: documents.length,
        separatorBuilder: (context, index) => AppSizses.height(AppSizses.m),
        itemBuilder: (context, index) {
          final document = documents[index];

          return DocumentCard(
            document: document,
            onTap: () {
              if (document.isDownloaded) {
                PdfViewerRoute(documentId: document.id).push(context);
              } else {
                SnackBarHelper.showErrorSnackBar(
                  context: context,
                  message:
                      'Document needs to be downloaded first. Please click the download button.',
                );
              }
            },
            onDownload: () {
              // Show a blocking modal dialog that tracks progress.
              // The dialog dispatches DownloadDocumentEvent internally
              // and auto-closes on completion — preventing any navigation
              // or interaction until the download finishes.
              DownloadProgressDialog.show(context, document);
            },
            onDelete: () {
              ConfirmationDialog.show(
                context: context,
                title: 'Delete Document',
                message:
                    'Are you sure you want to delete "${document.name}"?',
                confirmLabel: 'Delete',
                confirmColor: Theme.of(context).colorScheme.error,
                onConfirm: () {
                  context.read<DocumentsBloc>().add(
                    DeleteDocumentEvent(document.id),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
