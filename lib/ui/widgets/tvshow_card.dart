import 'package:ballastlane_app/domain/entities/tv_show.dart';
import 'package:flutter/material.dart';

class TvShowCard extends StatelessWidget {
  final TvShow tvShow;
  const TvShowCard({super.key, required this.tvShow});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        border: Border.all(
          color: Colors.black12,
          width: 1,
        ),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Image.network(tvShow.imageUrl),
                Positioned(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(tvShow.name),
                      ),
                      Text(tvShow.rating.toString()),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
