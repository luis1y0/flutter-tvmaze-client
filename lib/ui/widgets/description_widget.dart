import 'package:ballastlane_app/domain/entities/tv_show.dart';
import 'package:ballastlane_app/ui/widgets/genres_widget.dart';
import 'package:flutter/material.dart';
import 'package:simple_html_css/simple_html_css.dart';

class DescriptionWidget extends StatelessWidget {
  final TvShow show;
  const DescriptionWidget({super.key, required this.show});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.4,
                child: Text('Show Type: ${show.type}'),
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.4,
                child: Text('Language: ${show.language}'),
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.4,
                child: Text('Status: ${show.status}'),
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.4,
                child: Text('Premiered: ${formatedDatetime(show.premiered)}'),
              ),
            ],
          ),
          Text('Network: ${show.network}'),
          const SizedBox(
            height: 16.0,
          ),
          GenresWidget(
            genres: show.genres,
          ),
          const SizedBox(
            height: 16.0,
          ),
          RichText(
            text: HTML.toTextSpan(context, show.summary),
          ),
        ],
      ),
    );
  }

  String formatedDatetime(DateTime datetime) {
    return '${datetime.year}-${datetime.month.toString().padLeft(2, '0')}-${datetime.day.toString().padLeft(2, '0')}';
  }
}
