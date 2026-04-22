import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_stream_docs/core/utils/helpers/snackbar_helper.dart';
import 'package:secure_stream_docs/features/documents/presentation/logic/document/documents_bloc.dart';
import 'package:secure_stream_docs/features/documents/presentation/ui/widgets/document/document_list.dart';
import 'package:secure_stream_docs/features/documents/presentation/ui/widgets/document/empty_state.dart';
import 'package:secure_stream_docs/features/documents/presentation/ui/widgets/document/error_state.dart';

class DocumentsScreen extends StatelessWidget {
  const DocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<DocumentsBloc, DocumentsState>(
        listener: (context, state) {
          if (state is DocumentsError) {
            // Handle error silently or show a toast
            SnackBarHelper.showErrorSnackBar(
              context: context,
              message: state.message,
            );
          }
        },

        builder: (context, state) {
          // Loading
          if (state is DocumentsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Error (only when no data)
          if (state is DocumentsError) {
            return ErrorState(
              message: state.message,
              onRetry: () => context.read<DocumentsBloc>().add(LoadDocuments()),
            );
          }

          // Loaded
          if (state is DocumentsLoaded) {
            if (state.documents.isEmpty) {
              return const EmptyState();
            }

            return DocumentList(documents: state.documents);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
