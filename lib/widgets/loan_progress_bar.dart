import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loantrack/helpers/colors.dart';

import '../models/loan.dart';

class LoanProgressBar extends StatefulWidget {
  LoanProgressBar({Key? key, required this.loan}) : super(key: key);

  Loan loan;

  @override
  State<LoanProgressBar> createState() => _LoanProgressBarState();
}

class _LoanProgressBarState extends State<LoanProgressBar> {
  @override
  Widget build(BuildContext context) {
    // Screensizes
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Progress
    double progress = (widget.loan.amountRepaid / widget.loan.loanAmount);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(children: [
          Container(
            width: screenWidth * screenWidth,
            height: 5,
            decoration: BoxDecoration(
              color: (progress >= 0.5)
                  ? LoanTrackColors.PrimaryOneLight
                  : LoanTrackColors.PrimaryTwoVeryLight,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          Container(
            width: screenWidth * progress,
            height: 5,
            decoration: BoxDecoration(
              color: (progress >= 0.5)
                  ? LoanTrackColors.PrimaryOne
                  : LoanTrackColors.PrimaryTwoLight,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ]),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.loan.loanInfo('|'),
              style: TextStyle(
                  color: LoanTrackColors.PrimaryTwoLight, fontSize: 12),
            ),
            (widget.loan.amountRepaid == widget.loan.loanAmount)
                ? Text(
                    'PAID',
                    style: TextStyle(color: LoanTrackColors.PrimaryOne),
                  )
                : Text(''),
          ],
        )
      ],
    );
  }
}
