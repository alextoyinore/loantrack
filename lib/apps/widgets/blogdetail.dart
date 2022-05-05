import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loantrack/helpers/common_widgets.dart';

import '../../helpers/colors.dart';

class BlogDetail extends StatefulWidget {
  BlogDetail({Key? key, required this.blog}) : super(key: key);

  DocumentSnapshot blog;

  @override
  State<BlogDetail> createState() => _BlogDetailState();
}

class _BlogDetailState extends State<BlogDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: (widget.blog != null)
              ? Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 2.5,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.blog.get('featuredImage')),
                      )),
                    ),
                    separatorSpace10,
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          Text(
                            widget.blog.get('title'),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          separatorSpace10,
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    widget.blog.get('author_image')),
                                radius: 30,
                              ),
                              horizontalSeparatorSpace10,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.blog.get('author'),
                                    style: const TextStyle(
                                        color: LoanTrackColors
                                            .PrimaryTwoVeryLight),
                                  ),
                                  Text(
                                    widget.blog.get('socials'),
                                    style: const TextStyle(
                                        color: LoanTrackColors
                                            .PrimaryTwoVeryLight),
                                  ),
                                  Text(
                                    widget.blog.get('whenPublished'),
                                    style: const TextStyle(
                                        color: LoanTrackColors
                                            .PrimaryTwoVeryLight),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          separatorSpace20,
                          Text(
                            widget.blog.get('content'),
                            style: const TextStyle(
                              color: LoanTrackColors.PrimaryTwoLight,
                              fontSize: 16,
                              height: 1.5,
                            ),
                            softWrap: true,
                            //textAlign: TextAlign.justify,
                          ),
                          separatorSpace20,
                          Row(
                            children: List.generate(
                                widget.blog.get('tags').split(',').length,
                                (index) {
                              return Container(
                                margin: const EdgeInsets.all(5),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color:
                                        LoanTrackColors.PrimaryOne.withOpacity(
                                            .1),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                    widget.blog.get('tags').split(',')[index]),
                              );
                            }),
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
