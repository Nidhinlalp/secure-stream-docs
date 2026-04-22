import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_stream_docs/core/ui/themes/app_colors.dart';
import 'package:secure_stream_docs/features/video_player/presentation/logic/bloc/video_player_bloc.dart';

/// VideoActionRow
///
/// Contains:
///   1. A custom URL text field — on submit, validates the URL, dispatches
///      [AddCustomUrl] then [LoadVideo] via [VideoPlayerBloc].
///   2. A Download action button (placeholder; extend as needed).
///
/// URL validation and Bloc dispatch are handled here, keeping
/// [VideoScreenView] clean.
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

  // ── Validation ────────────────────────────────────────────────────────────

  bool _isValidUrl(String url) {
    final trimmed = url.trim();
    if (trimmed.isEmpty) return false;
    final uri = Uri.tryParse(trimmed);
    if (uri == null || !uri.hasAbsolutePath) return false;
    if (!uri.scheme.startsWith('http')) return false;
    // Accept any URL; HLS format is validated at the player level.
    return true;
  }

  // ── Submit handler ────────────────────────────────────────────────────────

  void _onLoad() {
    final url = _urlController.text.trim();

    if (!_isValidUrl(url)) {
      setState(() {
        _validationError =
            'Please enter a valid URL (must start with http:// or https://)';
      });
      return;
    }

    setState(() => _validationError = null);
    _focusNode.unfocus();

    final bloc = context.read<VideoPlayerBloc>();
    bloc
      ..add(AddCustomUrl(url))
      ..add(LoadVideo(url));

    _urlController.clear();
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Custom URL row ───────────────────────────────────────────────
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
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
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
            const SizedBox(width: 8),
            // Send/Load button
            BlocBuilder<VideoPlayerBloc, VideoPlayerState>(
              builder: (context, state) {
                final isLoading = state is VideoPlayerLoading;
                return SizedBox(
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: isLoading ? null : _onLoad,
                    icon: isLoading
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.send_rounded, size: 18),
                    label: const Text('Load'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                );
              },
            ),
          ],
        ),

        const SizedBox(height: 12),
      ],
    );
  }
}
