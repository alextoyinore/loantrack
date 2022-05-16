import 'package:flutter/material.dart';
import 'package:loantrack/helpers/listwidgets.dart';

import '../helpers/colors.dart';
import '../widgets/common_widgets.dart';

class NewsApp extends StatelessWidget {
  const NewsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          separatorSpace50,
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
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
                  style: TextStyle(
                      color: LoanTrackColors2.PrimaryOne, fontSize: 20),
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
          //separatorSpace10,
          SingleChildScrollView(
            child: NewsList(height: MediaQuery.of(context).size.height * .85),
          ),
        ],
      ),
    );
  }
}
