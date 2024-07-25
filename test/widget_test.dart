import 'package:ballastlane_app/domain/entities/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:ballastlane_app/domain/repositories/api_repository.dart';
import 'package:ballastlane_app/implementation/repositories/tvmaze_repository.dart';
import 'package:mockito/annotations.dart';

import 'widget_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {
  group('Api Repository', () {
    var client = MockClient();
    final ApiRepository repository = TvmazeRepository(client);
    final showJson =
        '''{"id":590,"url":"https://www.tvmaze.com/shows/590/pokemon","name":"Pokémon","type":"Animation","language":"Japanese","genres":["Adventure","Anime","Fantasy"],"status":"Running","runtime":30,"averageRuntime":25,"premiered":"1997-04-01","ended":null,"officialSite":"https://www.tv-tokyo.co.jp/anime/pocketmonster/","schedule":{"time":"18:55","days":["Friday"]},"rating":{"average":7.8},"weight":97,"network":{"id":76,"name":"TV Tokyo","country":{"name":"Japan","code":"JP","timezone":"Asia/Tokyo"},"officialSite":null},"webChannel":null,"dvdCountry":null,"externals":{"tvrage":31,"thetvdb":76703,"imdb":"tt0168366"},"image":{"medium":"https://static.tvmaze.com/uploads/images/medium_portrait/459/1148947.jpg","original":"https://static.tvmaze.com/uploads/images/original_untouched/459/1148947.jpg"},"summary":"<p>The great adventures of 10 year old Ash Ketchum, a young <b>Pokémon</b> Trainer from Pallet Town, as well as his best friend and everlasting companion Pikachu. Together, they venture through many regions: the traditional region of Kanto, the culturally rich Johto, the temperate region of Hoenn, the mystical region of Sinnoh, the advanced landscapes of Unova, Kalos, with it's many landmarks, the splendor of the tropics of Alola, and the expansive Galar. Along the way, they meet many new companions, many new friends and new rivals, while also competing in each regional league; as well as toppling evil organizations, and outsmarting the pesky and persistent Team Rocket. However, through all this, Ash's goal remains unchanged: to discover many new Pokémon, and to become regarded as the world's greatest Pokémon Master.</p>","updated":1721676431,"_links":{"self":{"href":"https://api.tvmaze.com/shows/590"},"previousepisode":{"href":"https://api.tvmaze.com/episodes/2937822","name":"The Mascot Pokémon Is Kingambit?!"},"nextepisode":{"href":"https://api.tvmaze.com/episodes/2937823","name":"Dance, Quaxly! Dance the Blue Medali Dance!!"}}}''';
    test('Show is not found', () {
      when(client.get(Uri.parse('https://api.tvmaze.com/shows/1')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      expect(
          repository.fetchTvShowById(1), throwsA(isA<ShowNotFoundException>()));
    });
    test('Show is parsed succesfully', () async {
      when(client.get(Uri.parse('https://api.tvmaze.com/shows/590')))
          .thenAnswer((_) async => http.Response(showJson, 200));
      var tvShow = await repository.fetchTvShowById(590);
      expect(tvShow.name, 'Pokémon');
    });
  });
}
