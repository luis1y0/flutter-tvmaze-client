import 'dart:convert';
import 'package:ballastlane_app/domain/entities/tv_show.dart';
import 'package:ballastlane_app/domain/repositories/api_repository.dart';
import 'package:http/http.dart' as http;
part '../models/tv_show.dart';

class TvmazeRepository extends ApiRepository {
  final http.Client client;

  TvmazeRepository(this.client);
  @override
  Future<List<TvShow>> fetchPokemonList() async {
    try {
      String url = 'https://api.tvmaze.com/search/shows?q=pokemon';
      var uri = Uri.parse(url);
      var response = await client.get(uri);
      List responseList = jsonDecode(response.body) as List;
      List<_TvShow> tvShows = [];
      for (Map<String, dynamic> item in responseList) {
        tvShows.add(_TvShow(
          id: item['show']['id'],
          name: item['show']['name'],
          imageUrl: item['show']['image']['medium'],
          rating: item['show']['rating']['average'] ?? 0.0,
        ));
      }
      return tvShows;
    } catch (e) {
      return [];
    }
  }
}
