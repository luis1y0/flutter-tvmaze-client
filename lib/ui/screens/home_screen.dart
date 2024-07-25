import 'package:ballastlane_app/domain/entities/tv_show.dart';
import 'package:ballastlane_app/domain/repositories/api_repository.dart';
import 'package:ballastlane_app/ui/blocs/auth_bloc.dart';
import 'package:ballastlane_app/ui/blocs/search_bloc.dart';
import 'package:ballastlane_app/ui/screens/detail_screen.dart';
import 'package:ballastlane_app/ui/widgets/tvshow_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var searchBloc =
        SearchBloc(Provider.of<ApiRepository>(context, listen: false));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: const Text('Sign Out'),
                  onTap: () {
                    var authBloc =
                        Provider.of<AuthBloc>(context, listen: false);
                    authBloc.add(Signout());
                  },
                ),
              ];
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            SearchAnchor(
              isFullScreen: false,
              viewConstraints: const BoxConstraints(),
              builder: (context, controller) {
                return SearchBar(
                  controller: _searchController,
                  hintText: 'Type to search...',
                  onSubmitted: (value) {
                    searchBloc.add(SearchQuery(query: value));
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
              child: BlocConsumer<SearchBloc, SearchState>(
                bloc: searchBloc,
                listenWhen: (previous, current) => current is ErrorOfSearch,
                listener: (context, state) {
                  if (state is ErrorOfSearch) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(state.message),
                    ));
                  }
                },
                builder: (context, state) {
                  if (state is ListedResults) {
                    return ListView.builder(
                      itemCount: state.results.length,
                      itemBuilder: (context, index) {
                        TvShowResult tvShow = state.results[index];
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
                  }
                  return const Center(
                    child: Text('There\'s no results to show.'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
