import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loantrack/helpers/colors.dart';

class LoanProgressBar extends StatefulWidget {
  LoanProgressBar({Key? key, required this.snapshot}) : super(key: key);

  DocumentSnapshot? snapshot;

  @override
  State<LoanProgressBar> createState() => _LoanProgressBarState();
}

class _LoanProgressBarState extends State<LoanProgressBar> {
  @override
  Widget build(BuildContext context) {
    // Screensizes
    double screenWidth = MediaQuery.of(context).size.width;

    // Progress
    double progress = (widget.snapshot!.get('amountRepaid') /
        widget.snapshot!.get('loanAmount'));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(children: [
          Container(
            width: screenWidth * screenWidth,
            height: 2,
            decoration: BoxDecoration(
              color: (progress >= 0.5)
                  ? LoanTrackColors.PrimaryOneLight
                  : LoanTrackColors.PrimaryTwoVeryLight,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          Container(
            width: screenWidth * progress,
            height: 2,
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
              '${widget.snapshot!.get('lender').toString().toUpperCase()} | LOAN: ${widget.snapshot!.get('loanAmount').toString().toUpperCase()} | REPAID: ${widget.snapshot!.get('amountRepaid')}',
              style: TextStyle(
                  color: LoanTrackColors.PrimaryTwoLight, fontSize: 12),
            ),
            (widget.snapshot!.get('amountRepaid') ==
                    widget.snapshot!.get('loanAmount'))
                ? const Text(
                    'PAID',
                    style: TextStyle(
                        color: LoanTrackColors.PrimaryOne, fontSize: 12),
                  )
                : Text(widget.snapshot!.get('lastPaidWhen').toString(),
                    style: TextStyle(
                        color: LoanTrackColors.PrimaryTwoLight, fontSize: 12),
                    softWrap: true),
          ],
        )
      ],
    );
  }
}
