class UrlValidator {
  UrlValidator._();

  /// Returns `true` when [url] is a syntactically valid HTTP/HTTPS URL.
  static bool isValidUrl(String url) {
    final trimmed = url.trim();
    if (trimmed.isEmpty) return false;
    final uri = Uri.tryParse(trimmed);
    if (uri == null || !uri.hasAbsolutePath) return false;
    if (!uri.scheme.startsWith('http')) return false;
    return true;
  }
}
