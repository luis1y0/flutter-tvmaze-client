class TvShowResult {
  final int id;
  final String name;
  final String imageUrl;
  final double? rating;
  const TvShowResult({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.rating,
  });
}

class TvShow extends TvShowResult {
  final String type;
  final String language;
  final String url;
  final List<String> genres;
  final String status;
  final DateTime premiered;
  final String summary;
  final String network;
  const TvShow({
    required super.id,
    required super.name,
    required super.imageUrl,
    required this.type,
    required this.language,
    required this.url,
    required this.genres,
    required this.status,
    required this.premiered,
    required this.summary,
    required this.network,
    super.rating,
  });
}
