import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loantrack/apps/widgets/button.dart';
import 'package:loantrack/apps/widgets/newsfullviewer.dart';

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
      body: SingleChildScrollView(
        child: Container(
          child: (widget.news != null)
              ? Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 2.5,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.news.get('featuredImage')),
                      )),
                    ),
                    separatorSpace10,
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.news.get('title'),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: LoanTrackColors.PrimaryOne,
                            ),
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
                            style: const TextStyle(
                              color: LoanTrackColors.PrimaryTwoLight,
                              fontSize: 16,
                              height: 1.5,
                            ),
                            softWrap: true,
                            //textAlign: TextAlign.justify,
                          ),
                          separatorSpace20,
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          NewsFullViewer(news: widget.news)));
                            },
                            child: LoanTrackButton.primary(
                                context: context, label: 'Continue Reading'),
                          ),
                          separatorSpace20,
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: LoanTrackButton.secondaryOutline(
                                context: context, label: 'Go Back'),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              : const Center(
                  child: Text('No data'),
                ),
        ),
      ),
    );
  }
}
