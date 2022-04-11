import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loantrack/apps/widgets/loan_list.dart';
import 'package:loantrack/apps/widgets/text_button.dart';
import 'package:loantrack/data/local.dart';
import 'package:loantrack/helpers/colors.dart';

class LoanHistoryApp extends StatefulWidget {
  const LoanHistoryApp({Key? key}) : super(key: key);

  @override
  State<LoanHistoryApp> createState() => _LoanHistoryAppState();
}

class _LoanHistoryAppState extends State<LoanHistoryApp> {
  double totalRepaid = 0;
  double totalInLoan = 0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Totals
    for (var i = 0; i < LocalData.loans.length; i++) {
      totalRepaid += LocalData.loans[i].amountRepaid;
      totalInLoan +=
          LocalData.loans[i].loanAmount - LocalData.loans[i].amountRepaid;
    }

    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('LOAN HISTORY APP',
              style: TextStyle(color: LoanTrackColors.PrimaryTwoLight)),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: screenWidth / 2.3,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: LoanTrackColors.PrimaryOne)),
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TOTAL REPAID',
                      style: TextStyle(color: LoanTrackColors.PrimaryOne),
                    ),
                    Text(
                      totalRepaid.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: LoanTrackColors.PrimaryOne),
                    )
                  ],
                ),
              ),
              Container(
                width: screenWidth / 2.3,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: LoanTrackColors.PrimaryTwoLight)),
                child: Column(
                  children: [
                    Text('TOTAL LOAN',
                        style:
                            TextStyle(color: LoanTrackColors.PrimaryTwoLight)),
                    Text(
                      totalInLoan.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: LoanTrackColors.PrimaryTwoLight),
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LoanTrackTextButton(
                onPressed: () {},
                label: 'Date',
                isPrimary: true,
              ),
              LoanTrackTextButton(
                onPressed: () {},
                label: 'Loaner',
              ),
              LoanTrackTextButton(
                onPressed: () {},
                label: 'Amount',
              ),
              LoanTrackTextButton(
                onPressed: () {},
                label: 'Repaid',
              )
            ],
          ),
          SizedBox(height: 20),
          SingleChildScrollView(
              child: Container(
                  height: screenHeight * .60,
                  child: LoanList(loanList: LocalData.loans))),
        ],
      ),
    );
  }
}
