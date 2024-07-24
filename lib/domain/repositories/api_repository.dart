import 'package:ballastlane_app/domain/entities/tv_show.dart';

abstract class ApiRepository {
  Future<List<TvShow>> fetchPokemonList();
}
