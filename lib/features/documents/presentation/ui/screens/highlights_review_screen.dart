import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:secure_stream_docs/core/utils/helpers/highlight_helper.dart';
import 'package:secure_stream_docs/features/documents/presentation/logic/highlight/highlight_cubit.dart';
import 'package:secure_stream_docs/features/documents/presentation/ui/widgets/highlight/highlight_page_section.dart';

class HighlightsReviewScreen extends StatefulWidget {
  final String documentId;

  const HighlightsReviewScreen({super.key, required this.documentId});

  @override
  State<HighlightsReviewScreen> createState() => _HighlightsReviewScreenState();
}

class _HighlightsReviewScreenState extends State<HighlightsReviewScreen> {
  @override
  void initState() {
    super.initState();
    _onInit();
  }

  void _onInit() {
    context.read<HighlightCubit>().load(widget.documentId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Highlights'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocBuilder<HighlightCubit, HighlightState>(
        builder: (context, state) {
          if (state is HighlightLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is HighlightError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 48,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () => context.read<HighlightCubit>().load(
                        widget.documentId,
                      ),
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is HighlightLoaded) {
            if (state.highlights.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.highlight_off, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      'No highlights yet',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Select text in the PDF viewer to add highlights',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              );
            }

            // Group the flat highlight list into a Map<pageNumber, highlights>.
            // Each page's highlights are already sorted by createdAt inside
            // the helper so they appear in chronological order within a section.
            final grouped = HighlightHelper.groupByPage(state.highlights);

            // Extract the page numbers and sort them in ascending order so
            // the ListView renders Page 1 → Page 2 → … from top to bottom.
            final sortedPages = grouped.keys.toList()..sort();

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: sortedPages.length,
              itemBuilder: (context, index) {
                final page = sortedPages[index];
                final pageHighlights = grouped[page]!;

                return HighlightPageSection(
                  pageNumber: page,
                  highlights: pageHighlights,
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
