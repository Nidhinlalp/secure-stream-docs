import 'package:flutter/material.dart';

class HighlightToolbar extends StatelessWidget {
  final VoidCallback onHighlight;
  final VoidCallback onCancel;

  const HighlightToolbar({
    super.key,
    required this.onHighlight,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 6,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            const Icon(Icons.text_fields, size: 18),
            const SizedBox(width: 8),
            const Expanded(child: Text('Text selected')),
            TextButton.icon(
              onPressed: onCancel,
              icon: const Icon(Icons.close, size: 18),
              label: const Text('Cancel'),
            ),
            const SizedBox(width: 8),
            FilledButton.icon(
              onPressed: onHighlight,
              icon: const Icon(Icons.highlight, size: 18),
              label: const Text('Highlight'),
            ),
          ],
        ),
      ),
    );
  }
}
