import 'package:ballastlane_app/domain/repositories/api_repository.dart';
import 'package:ballastlane_app/ui/widgets/tvshow_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  final int showId;
  const DetailScreen({super.key, required this.showId});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Screen'),
      ),
      body: FutureBuilder(
        future:
            Provider.of<ApiRepository>(context).fetchTvShowById(widget.showId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return TvShowCard(tvShow: snapshot.data!);
        },
      ),
    );
  }
}
