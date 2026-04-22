import 'package:flutter/material.dart';

import 'package:secure_stream_docs/core/utils/helpers/date_format_helper.dart';
import 'package:secure_stream_docs/features/documents/domain/entities/highlight.dart';

class HighlightCard extends StatelessWidget {
  final Highlight highlight;

  const HighlightCard({super.key, required this.highlight});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormatHelper.formatDateTime(highlight.createdAt);

    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Colour swatch
            Container(
              width: 6,
              height: 48,
              decoration: BoxDecoration(
                color: highlight.color,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            const SizedBox(width: 12),

            // Text + timestamp
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    highlight.text,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    formattedDate,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
