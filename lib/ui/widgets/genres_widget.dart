import 'package:flutter/material.dart';

class GenresWidget extends StatelessWidget {
  final List<String> genres;
  const GenresWidget({super.key, required this.genres});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      runAlignment: WrapAlignment.start,
      spacing: 8,
      runSpacing: 4,
      children: [
        const Text('Genres: '),
        ...genres.map(
          (genre) => Chip(
            label: Text(genre),
          ),
        ),
      ],
    );
  }
}
