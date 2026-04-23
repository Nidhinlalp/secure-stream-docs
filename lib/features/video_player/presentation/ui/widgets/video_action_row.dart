import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:secure_stream_docs/core/ui/themes/app_colors.dart';
import 'package:secure_stream_docs/core/ui/themes/app_sizes.dart';
import 'package:secure_stream_docs/core/utils/helpers/url_validator.dart';
import 'package:secure_stream_docs/features/video_player/presentation/logic/bloc/video_player_bloc.dart';

class VideoActionRow extends StatefulWidget {
  const VideoActionRow({super.key});

  @override
  State<VideoActionRow> createState() => _VideoActionRowState();
}

class _VideoActionRowState extends State<VideoActionRow> {
  final TextEditingController _urlController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String? _validationError;

  @override
  void dispose() {
    _urlController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onLoad() {
    final url = _urlController.text.trim();

    if (!UrlValidator.isValidUrl(url)) {
      setState(() {
        _validationError =
            'Please enter a valid URL (must start with http:// or https://)';
      });
      return;
    }

    setState(() => _validationError = null);
    _focusNode.unfocus();

    final videoPlayerBloc = context.read<VideoPlayerBloc>();

    videoPlayerBloc.add(AddCustomUrl(url));
    videoPlayerBloc.add(LoadVideo(url));

    _urlController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextField(
                controller: _urlController,
                focusNode: _focusNode,
                keyboardType: TextInputType.url,
                textInputAction: TextInputAction.go,
                onSubmitted: (_) => _onLoad(),
                decoration: InputDecoration(
                  hintText: 'Enter HLS stream URL...',
                  prefixIcon: const Icon(Icons.link_rounded),
                  suffixIcon: _urlController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear_rounded),
                          onPressed: () {
                            _urlController.clear();
                            setState(() => _validationError = null);
                          },
                          tooltip: 'Clear',
                        )
                      : null,
                  border: const OutlineInputBorder(),
                  errorText: _validationError,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: AppSizses.m.sp,
                    vertical: AppSizses.m.sp,
                  ),
                ),
                onChanged: (_) {
                  // Clear validation error as user types
                  if (_validationError != null) {
                    setState(() => _validationError = null);
                  }
                  // Rebuild to show/hide clear button
                  setState(() {});
                },
              ),
            ),
            AppSizses.width(AppSizses.s),
            // Send Load button
            BlocBuilder<VideoPlayerBloc, VideoPlayerState>(
              builder: (context, state) {
                final isLoading = state is VideoPlayerLoading;
                return SizedBox(
                  height: AppSizses.xl2.sp,
                  child: ElevatedButton.icon(
                    onPressed: isLoading ? null : _onLoad,
                    icon: isLoading
                        ? SizedBox(
                            width: AppSizses.l.sp,
                            height: AppSizses.l.sp,
                            child: CircularProgressIndicator(
                              strokeWidth: AppSizses.px1.sp,
                              color: AppColors.onPrimary,
                            ),
                          )
                        : Icon(Icons.send_rounded, size: AppSizses.l1.sp),
                    label: const Text('Load'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.onPrimary,
                      padding: EdgeInsets.symmetric(horizontal: AppSizses.m.sp),
                    ),
                  ),
                );
              },
            ),
          ],
        ),

        AppSizses.height(AppSizses.m),
      ],
    );
  }
}
