import 'package:ballastlane_app/domain/entities/tv_show.dart';

abstract class ApiRepository {
  Future<List<TvShow>> fetchTvShows(String query);
  Future<TvShow> fetchTvShowById(int id);
}
