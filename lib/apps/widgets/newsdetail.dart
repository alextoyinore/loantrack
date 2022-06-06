import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loantrack/apps/widgets/button.dart';
import 'package:loantrack/apps/widgets/newsfullviewer.dart';
import 'package:loantrack/helpers/styles.dart';

import '../../helpers/colors.dart';
import '../../widgets/common_widgets.dart';

class NewsDetail extends StatefulWidget {
  NewsDetail({Key? key, required this.news}) : super(key: key);

  DocumentSnapshot news;

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
        height: 400,
      ),
      ShaderMask(
        shaderCallback: (rect) {
          return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).colorScheme.background,
                Colors.transparent,
              ]).createShader(Rect.fromLTRB(
            0,
            0,
            rect.width,
            rect.height,
          ));
        },
        blendMode: BlendMode.dstIn,
        child: Container(
          height: MediaQuery.of(context).size.height / 2.5,
          decoration: BoxDecoration(
              image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(widget.news.get('featuredImage')),
          )),
        ),
      ),
      SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              const SizedBox(
                height: 300,
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.news.get('title'),
                      style: smallTitleStyle(context),
                    ),
                    separatorSpace10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.news.get('source'),
                          style: const TextStyle(
                              color: LoanTrackColors.PrimaryTwoVeryLight),
                        ),
                        horizontalSeparatorSpace20,
                        Text(
                          widget.news.get('whenPublished'),
                          style: const TextStyle(
                              color: LoanTrackColors.PrimaryTwoVeryLight),
                        ),
                      ],
                    ),
                    separatorSpace20,
                    Text(
                      widget.news.get('excerpt'),
                      style: descriptionStyle(context),
                      softWrap: true,
                      //textAlign: TextAlign.justify,
                    ),
                    separatorSpace20,
                    LoanTrackButton.primary(
                        whenPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      NewsFullViewer(news: widget.news)));
                        },
                        context: context,
                        label: 'Continue Reading'),
                    separatorSpace20,
                    LoanTrackButton.primaryOutline(
                        whenPressed: () {
                          Navigator.pop(context);
                        },
                        context: context,
                        label: 'Go Back'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ]));
  }
}
