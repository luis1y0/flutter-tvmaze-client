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
      premiered: DateTime.now(),
      summary: data['summary'],
      network: data['network']['name'],
    );
  }
}
