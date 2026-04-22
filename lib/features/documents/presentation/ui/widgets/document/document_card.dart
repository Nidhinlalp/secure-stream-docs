import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:secure_stream_docs/core/ui/themes/app_colors.dart';
import 'package:secure_stream_docs/core/ui/themes/app_sizes.dart';
import 'package:secure_stream_docs/core/ui/themes/app_text_theme.dart';
import 'package:secure_stream_docs/features/documents/domain/entities/document.dart';
import 'package:secure_stream_docs/features/documents/presentation/ui/widgets/document/download_button.dart';
import 'package:secure_stream_docs/features/documents/presentation/ui/widgets/document/download_progress.dart';

class DocumentCard extends StatelessWidget {
  final Document document;
  final VoidCallback? onTap;
  final VoidCallback? onDownload;
  final VoidCallback? onDelete;

  const DocumentCard({
    super.key,
    required this.document,
    this.onTap,
    this.onDownload,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizses.m.sp),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSizses.m.sp),
        child: Padding(
          padding: EdgeInsets.all(AppSizses.l.sp),
          child: Row(
            children: [
              // PDF Icon
              Container(
                width: AppSizses.xl2.sp,
                height: AppSizses.xl2.sp,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppSizses.s.sp),
                ),
                child: Icon(
                  Icons.picture_as_pdf,
                  color: AppColors.primary,
                  size: AppSizses.l3.sp,
                ),
              ),

              AppSizses.width(AppSizses.l),

              // Document info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      document.name,
                      style: AppTextStyle.titleMedium(context)?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    AppSizses.height(AppSizses.xs),
                    Text(
                      document.isDownloaded ? "Downloaded" : "Not downloaded",
                      style: AppTextStyle.bodySmall(context)?.copyWith(
                        color: AppColors.textSecondary(context),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              AppSizses.width(AppSizses.l),

              // Action buttons
              if (document.isDownloading)
                DownloadProgress(progress: document.progress)
              else
                _buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    // If downloaded
    if (document.isDownloaded) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: onTap,
            icon: const Icon(Icons.open_in_new),
            tooltip: 'Open',
            color: AppColors.primary,
          ),
          AppSizses.width(AppSizses.s),
          IconButton(
            onPressed: onDelete,
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Delete',
            color: AppColors.error,
          ),
        ],
      );
    }

    // If not downloaded
    return DownloadButton(onPressed: onDownload);
  }
}
