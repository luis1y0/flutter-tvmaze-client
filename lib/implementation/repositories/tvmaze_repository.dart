import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:ballastlane_app/domain/entities/exceptions.dart';
import 'package:ballastlane_app/domain/entities/tv_show.dart';
import 'package:ballastlane_app/domain/repositories/api_repository.dart';
import 'package:http/http.dart' as http;
part '../models/tv_show.dart';

class TvmazeRepository extends ApiRepository {
  final http.Client client;

  TvmazeRepository(this.client);
  @override
  Future<List<TvShowResult>> fetchTvShows(String query) async {
    try {
      var q = Uri.encodeQueryComponent(query);
      String url = 'https://api.tvmaze.com/search/shows?q=$q';
      var uri = Uri.parse(url);
      var response = await client.get(uri);
      List responseList = jsonDecode(response.body) as List;
      List<_TvShowResult> tvShows = [];
      for (Map<String, dynamic> item in responseList) {
        tvShows.add(_TvShowResult(
          id: item['show']['id'],
          name: item['show']['name'],
          imageUrl: item['show']['image']['medium'],
          rating: item['show']['rating']['average'],
        ));
      }
      return tvShows;
    } on TimeoutException {
      return [];
    } on SocketException {
      return [];
    } on IOException {
      return [];
    } catch (e) {
      return [];
    }
  }

  @override
  Future<TvShow> fetchTvShowById(int id) async {
    try {
      String url = 'https://api.tvmaze.com/shows/$id';
      var uri = Uri.parse(url);
      var response = await client.get(uri);
      if (response.statusCode != 200) {
        throw ShowNotFoundException();
      }
      Map<String, dynamic> responseData = jsonDecode(response.body);
      return _TvShow.fromJson(responseData);
    } on TimeoutException {
      rethrow;
    } on SocketException {
      rethrow;
    } on IOException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
