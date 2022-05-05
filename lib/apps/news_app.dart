import 'package:flutter/material.dart';
import 'package:loantrack/helpers/functions.dart';

import '../helpers/colors.dart';
import '../helpers/common_widgets.dart';

class NewsApp extends StatelessWidget {
  const NewsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          separatorSpace30,
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'NEWS',
                  style: TextStyle(
                    fontSize: 20,
                    color: LoanTrackColors2.PrimaryOne,
                  ),
                )
              ],
            ),
          ),
          separatorSpace10,
          const Padding(
            padding: EdgeInsets.only(left: 24.0),
            child: Text(
              'Here we provide you with news from various media outlets to help you be on the know about your lenders',
              style: TextStyle(
                color: LoanTrackColors.PrimaryTwoVeryLight,
              ),
            ),
          ),
          separatorSpace10,
          SingleChildScrollView(
            child: NewsList(height: MediaQuery.of(context).size.height * .77),
          ),
        ],
      ),
    );
  }
}
