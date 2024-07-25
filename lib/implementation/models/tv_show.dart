part of '../repositories/tvmaze_repository.dart';

class _TvShowResult extends TvShowResult {
  const _TvShowResult({
    required super.id,
    required super.name,
    required super.imageUrl,
    required super.rating,
  });
}

class _TvShow extends TvShow {
  const _TvShow({
    required super.id,
    required super.name,
    required super.imageUrl,
    required super.rating,
    required super.type,
    required super.language,
    required super.url,
    required super.genres,
    required super.status,
    required super.premiered,
    required super.summary,
    required super.network,
  });

  factory _TvShow.fromJson(Map<String, dynamic> data) {
    String premiered = data['premiered'];
    RegExp pattern = RegExp(r'(\d{4})-(\d{2})-(\d{2})');
    List<Match> matches = pattern.allMatches(premiered).toList();
    Match match = matches[0];
    DateTime premieredDatetime = DateTime(
      int.parse(match[1]!),
      int.parse(match[2]!),
      int.parse(match[3]!),
    );
    return _TvShow(
      id: data['id'],
      name: data['name'],
      imageUrl: data['image']['medium'],
      rating: data['rating']['average'],
      type: data['type'],
      language: data['language'],
      url: data['url'],
      genres: List.from(data['genres']),
      status: data['status'],
      premiered: premieredDatetime,
      summary: data['summary'],
      network: data['network']?['name'] ?? '--',
    );
  }
}
