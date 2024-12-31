String extractImageUrl(String postThumbnail) {
  // Regex ile img etiketindeki src'yi bul
  final regExp = RegExp(r'src="([^"]+)"');
  final match = regExp.firstMatch(postThumbnail);
  return match != null ? match.group(1) ?? '' : '';
}
