import 'package:ballastlane_app/domain/entities/tv_show.dart';
import 'package:ballastlane_app/domain/repositories/api_repository.dart';
import 'package:ballastlane_app/ui/screens/detail_screen.dart';
import 'package:ballastlane_app/ui/widgets/tvshow_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SearchController _searchController = SearchController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            SearchAnchor(
              searchController: _searchController,
              isFullScreen: false,
              viewConstraints: const BoxConstraints(),
              builder: (context, controller) {
                return SearchBar(
                  controller: TextEditingController(text: controller.text),
                  trailing: const [
                    Icon(Icons.search),
                  ],
                  hintText: 'Type to search...',
                  onChanged: (value) {
                    controller.value = TextEditingValue(text: value);
                    if (value.isNotEmpty) controller.openView();
                  },
                );
              },
              viewHintText: 'Type to search...',
              suggestionsBuilder: (context, controller) {
                return [
                  const ListTile(
                    title: Text('Result 1'),
                  ),
                ];
              },
            ),
            Expanded(
              child: FutureBuilder<List<TvShowResult>>(
                  future: Provider.of<ApiRepository>(context)
                      .fetchTvShows('Pokemon'),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        TvShowResult tvShow = snapshot.data![index];
                        return TvShowCard(
                          tvShow: tvShow,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DetailScreen(
                                  showId: tvShow.id,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
