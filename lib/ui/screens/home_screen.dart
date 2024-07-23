import 'package:ballastlane_app/ui/screens/detail_screen.dart';
import 'package:flutter/material.dart';

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
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Item ${index + 1}'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const DetailScreen()),
                      );
                    },
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
