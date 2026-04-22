import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:secure_stream_docs/core/ui/themes/app_colors.dart';
import 'package:secure_stream_docs/core/ui/themes/app_sizes.dart';
import 'package:secure_stream_docs/core/ui/themes/app_text_theme.dart';
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
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.highlight_off,
                      size: AppSizses.xxl.sp,
                      color: AppColors.textSecondary(context),
                    ),
                    AppSizses.height(AppSizses.l),
                    Text(
                      'No highlights yet',
                      style: AppTextStyle.titleMedium(context)?.copyWith(
                        color: AppColors.textSecondary(context),
                      ),
                    ),
                    AppSizses.height(AppSizses.s),
                    Text(
                      'Select text in the PDF viewer to add highlights',
                      style: AppTextStyle.bodySmall(context)?.copyWith(
                        color: AppColors.textSecondary(context),
                      ),
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
              padding: EdgeInsets.all(AppSizses.l.sp),
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
