class UrlParams {
  final String url;
  const UrlParams(this.url);
}

class PlaybackParams {
  final String url;
  final int positionMs;

  const PlaybackParams({required this.url, required this.positionMs});
}
