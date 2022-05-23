import 'package:flutter/material.dart';
import 'package:loantrack/helpers/listwidgets.dart';

import '../helpers/colors.dart';
import '../widgets/common_widgets.dart';

class NewsApp extends StatelessWidget {
  const NewsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: LoanTrackColors.PrimaryOne,
        title: const Text(
          'Loan News',
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          separatorSpace5,
          const Padding(
            padding: EdgeInsets.only(
              left: 24.0,
              right: 24,
            ),
            child: Text(
              'Here we provide you with news from various media outlets to help you be on the know about your lenders',
              style: TextStyle(
                color: LoanTrackColors.PrimaryTwoVeryLight,
              ),
            ),
          ),
          separatorSpace10,
          SingleChildScrollView(
            child: NewsList(height: MediaQuery.of(context).size.height * .83),
          ),
        ],
      ),
    );
  }
}
