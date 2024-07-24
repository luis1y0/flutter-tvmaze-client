import 'dart:ui' as ui;

import 'package:ballastlane_app/domain/entities/tv_show.dart';
import 'package:flutter/material.dart';

class TvShowCard extends StatelessWidget {
  final TvShowResult tvShow;
  final VoidCallback? onTap;
  const TvShowCard({super.key, required this.tvShow, this.onTap});

  final TextStyle _textStyle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Positioned.fill(
                child: ImageFiltered(
                  imageFilter: ui.ImageFilter.blur(
                    sigmaX: 5.0,
                    sigmaY: 5.0,
                    tileMode: TileMode.decal,
                  ),
                  child: Image.network(
                    tvShow.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned.fill(
                child: Image.network(
                  tvShow.imageUrl,
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                child: Container(
                  color: Theme.of(context).primaryColor.withOpacity(0.7),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          tvShow.name,
                          style: _textStyle,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Icon(
                        Icons.star,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        tvShow.rating?.toString() ?? '--',
                        style: _textStyle,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
