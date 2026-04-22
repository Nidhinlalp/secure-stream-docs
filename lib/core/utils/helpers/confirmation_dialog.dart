import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:secure_stream_docs/core/ui/themes/app_sizes.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmLabel;
  final String cancelLabel;
  final Color? confirmColor;
  final VoidCallback onConfirm;

  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onConfirm,
    this.confirmLabel = 'Confirm',
    this.cancelLabel = 'Cancel',
    this.confirmColor,
  });

  /// Convenience method to show the dialog.
  static Future<void> show({
    required BuildContext context,
    required String title,
    required String message,
    required VoidCallback onConfirm,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
    Color? confirmColor,
  }) {
    return showDialog<void>(
      context: context,
      builder: (_) => ConfirmationDialog(
        title: title,
        message: message,
        onConfirm: onConfirm,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        confirmColor: confirmColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final effectiveColor =
        confirmColor ?? Theme.of(context).colorScheme.primary;

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizses.l.sp),
      ),
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(onPressed: () => context.pop(), child: Text(cancelLabel)),
        TextButton(
          onPressed: () {
            context.pop();
            onConfirm();
          },
          style: TextButton.styleFrom(foregroundColor: effectiveColor),
          child: Text(confirmLabel),
        ),
      ],
    );
  }
}
