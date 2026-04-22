import 'package:flutter/material.dart';

import 'package:secure_stream_docs/features/documents/domain/entities/highlight.dart';
import 'package:secure_stream_docs/features/documents/presentation/ui/widgets/highlight/highlight_card.dart';

class HighlightPageSection extends StatelessWidget {
  final int pageNumber;
  final List<Highlight> highlights;

  const HighlightPageSection({
    super.key,
    required this.pageNumber,
    required this.highlights,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Page header
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Icon(
                Icons.description_outlined,
                size: 20,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 8),
              Text(
                'Page $pageNumber',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '(${highlights.length} highlight${highlights.length > 1 ? 's' : ''})',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.grey),
              ),
            ],
          ),
        ),

        // Highlight cards
        ...highlights.map(
          (h) => HighlightCard(highlight: h),
        ),

        const SizedBox(height: 16),
      ],
    );
  }
}
