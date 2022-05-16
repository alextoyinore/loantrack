import 'package:flutter/material.dart';
import 'package:loantrack/helpers/colors.dart';

import '../../widgets/common_widgets.dart';
import '../../helpers/listwidgets.dart';

class NewsView extends StatefulWidget {
  const NewsView({Key? key}) : super(key: key);

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          margin: const EdgeInsets.only(top: 16),
          child: Row(
            children: const [
              Icon(
                Icons.newspaper,
                color: LoanTrackColors2.PrimaryOne,
                size: 20,
              ),
              SizedBox(width: 10),
              Text(
                'NEWS',
                style:
                    TextStyle(color: LoanTrackColors2.PrimaryOne, fontSize: 20),
              )
            ],
          ),
        ),
        separatorSpace10,
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
          child: Text(
            'Here we provide you with news from various media outlets to help you be on the know about your lenders',
            style: TextStyle(
              color: LoanTrackColors.PrimaryTwoVeryLight,
              fontSize: 12,
            ),
          ),
        ),
        NewsList(height: MediaQuery.of(context).size.height * .77),
      ],
    );
  }
}
