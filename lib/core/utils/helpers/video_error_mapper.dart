class VideoErrorMapper {
  VideoErrorMapper._();

  /// Maps a raw player/BLoC error string to a user-friendly message.
  static String getUserFriendlyError(String? raw) {
    if (raw == null || raw.isEmpty) return 'Failed to load video.';

    final lower = raw.toLowerCase();

    if (lower.contains('network') || lower.contains('connection')) {
      return 'Network error.\nCheck your connection and retry.';
    }

    if (lower.contains('codec') || lower.contains('decoder')) {
      return 'Your device couldn\'t decode this stream.\n'
          'Try a lower quality or different URL.';
    }

    if (lower.contains('source') || lower.contains('404')) {
      return 'Stream not found.\nCheck the URL and retry.';
    }

    if (lower.contains('timeout')) {
      return 'Connection timed out.\nPlease try again.';
    }

    return 'Failed to load the stream.\nPlease retry.';
  }
}
