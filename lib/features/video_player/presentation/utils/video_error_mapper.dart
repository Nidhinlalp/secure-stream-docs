class VideoErrorMapper {
  static String getUserFriendlyError(String raw) {
    if (raw.contains('SocketException') ||
        raw.contains('network') ||
        raw.contains('connection')) {
      return 'No internet connection. Please check your network and try again.';
    }
    if (raw.contains('404') || raw.contains('Not Found')) {
      return 'Video not found. The URL may be invalid or the stream has ended.';
    }
    if (raw.contains('invalid') || raw.contains('url') || raw.contains('URL')) {
      return 'Invalid stream URL. Please provide a valid HLS (.m3u8) link.';
    }
    if (raw.contains('timeout')) {
      return 'Connection timed out. Please try again.';
    }
    return 'Something went wrong. Please retry.';
  }
}
