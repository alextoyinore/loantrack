import 'package:flutter/material.dart';
import 'package:loantrack/apps/providers/loan_provider.dart';
import 'package:loantrack/apps/widgets/updateprofile.dart';
import 'package:loantrack/helpers/colors.dart';
import 'package:provider/provider.dart';

import '../helpers/styles.dart';
import '../widgets/common_widgets.dart';

class CreditScore extends StatefulWidget {
  const CreditScore({Key? key}) : super(key: key);

  @override
  State<CreditScore> createState() => _CreditScoreState();
}

class _CreditScoreState extends State<CreditScore> {
  @override
  double creditscore = -1;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double netIncome = context.read<LoanDetailsProviders>().netIncome;
    double currentLoanTotal = context.read<LoanDetailsProviders>().loanTotal;
    double repaidTotal = context.read<LoanDetailsProviders>().repaidTotal;
    String maritalStatus = context.read<LoanDetailsProviders>().maritalStatus;

    double incomeToLoanRatio = (netIncome / currentLoanTotal);
    double repaidToLoanRatio = (repaidTotal / currentLoanTotal);

    /* if (maritalStatus == '') {
      maritalStatus = 'Rather Not Say';
    }
*/
    int marriedRating = 0;

    switch (maritalStatus) {
      case 'Single':
        marriedRating = 2;
        break;
      case 'Married Without Kids':
        marriedRating = 4;
        break;
      case 'Married With Kids':
        marriedRating = 5;
        break;
      case 'Divorced':
        marriedRating = 3;
        break;
      case 'Rather Not Say':
        marriedRating = 1;
        break;
    }

    double marriedFactor = marriedRating / 5;

    double marriedPercent = marriedFactor * 10;
    double incomePercent = incomeToLoanRatio * 60;
    double repaidPercent = repaidToLoanRatio * 30;

    creditscore = (marriedPercent + incomePercent + repaidPercent);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: screenHeight / 4 + 20),
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 16,
            ),
            child: (creditscore < 0)
                ? Container(
                    height: screenHeight - 200,
                    width: screenWidth,
                    child: Center(
                      child: Column(
                        children: [
                          const Text(
                            'We do not have enough data to compute your loan Credit Score',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: LoanTrackColors.PrimaryTwoVeryLight,
                            ),
                          ),
                          separatorSpace5,
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ProfileUpdate()));
                            },
                            child: const Text(
                              'Update your profile now',
                              style: TextStyle(
                                color: LoanTrackColors.PrimaryOne,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: screenWidth,
                          height: screenHeight * .3,
                          child: Center(
                              child: Stack(
                            children: [
                              Container(
                                width: screenWidth / 2.5,
                                height: screenWidth / 2.5,
                                alignment: Alignment.bottomCenter,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                    color: (creditscore >= 50 &&
                                            creditscore <= 100)
                                        ? LoanTrackColors2.TetiaryOne
                                            .withOpacity(.3)
                                        : (creditscore >= 25 &&
                                                creditscore <= 49)
                                            ? LoanTrackColors.TetiaryOne
                                                .withOpacity(.3)
                                            : (creditscore < 24 &&
                                                    creditscore > -1)
                                                ? Colors.red.withOpacity(.3)
                                                : Colors.transparent,
                                  ),
                                ),
                                clipBehavior: Clip.hardEdge,
                                child: Container(
                                  color: (creditscore >= 50 &&
                                          creditscore <= 100)
                                      ? LoanTrackColors2.TetiaryOne.withOpacity(
                                          .2)
                                      : (creditscore >= 25 && creditscore <= 49)
                                          ? LoanTrackColors.TetiaryOne
                                              .withOpacity(.2)
                                          : (creditscore < 24 &&
                                                  creditscore > -1)
                                              ? Colors.red.withOpacity(.2)
                                              : Colors.transparent,
                                  width: screenWidth / 2.5,
                                  height: (creditscore / 100) *
                                      ((screenHeight / 2.5) / 2),
                                ),
                              ),
                              Container(
                                width: screenWidth / 2.5,
                                height: screenWidth / 2.5,
                                child: Center(
                                  child: Text(
                                    (creditscore * 100).floor().toString(),
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: (creditscore >= 50 &&
                                              creditscore <= 100)
                                          ? LoanTrackColors2.TetiaryOne
                                          : (creditscore >= 25 &&
                                                  creditscore <= 49)
                                              ? LoanTrackColors.TetiaryOne
                                              : (creditscore < 24 &&
                                                      creditscore > -1)
                                                  ? Colors.red
                                                  : Colors.transparent,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
                        ),
                        separatorSpace20,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: screenWidth / 25,
                                  width: screenWidth / 25,
                                  color: LoanTrackColors2.TetiaryOne,
                                ),
                                horizontalSeparatorSpace20,
                                const Text(
                                  'Your score is good',
                                  style: TextStyle(
                                    color: LoanTrackColors.PrimaryTwoVeryLight,
                                  ),
                                )
                              ],
                            ),
                            separatorSpace20,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: screenWidth / 25,
                                  width: screenWidth / 25,
                                  color: LoanTrackColors.TetiaryOne,
                                ),
                                horizontalSeparatorSpace20,
                                SizedBox(
                                  width: screenWidth * .7,
                                  child: const Text(
                                    'Your Credit Score is at an average. Consider keeping your borrowings below your net income.',
                                    style: TextStyle(
                                      color:
                                          LoanTrackColors.PrimaryTwoVeryLight,
                                    ),
                                    softWrap: true,
                                  ),
                                )
                              ],
                            ),
                            separatorSpace20,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: screenWidth / 25,
                                  width: screenWidth / 25,
                                  color: Colors.red,
                                ),
                                horizontalSeparatorSpace20,
                                SizedBox(
                                  width: screenWidth * .7,
                                  child: const Text(
                                    'Your score is bad. Seriously consider paying off all loans before taking on any other loan.',
                                    style: TextStyle(
                                      color:
                                          LoanTrackColors.PrimaryTwoVeryLight,
                                    ),
                                    softWrap: true,
                                  ),
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            height: screenHeight / 3.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                separatorSpace40,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.close),
                    )
                  ],
                ),
                separatorSpace20,
                Text(
                  'Score',
                  style: titleStyle(context),
                ),
                separatorSpace10,
                const Text(
                  'Welcome to Credit Score. Here you can see at a glance how viable you are for a loan. Your score will give you an idea of your chances of securing a loan.',
                  softWrap: true,
                  style: TextStyle(
                    color: LoanTrackColors.PrimaryTwoVeryLight,
                  ),
                ),
                separatorSpace10,
              ],
            ),
          )
        ],
      ),
    );
  }
}
