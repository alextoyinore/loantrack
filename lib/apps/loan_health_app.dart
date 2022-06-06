import 'package:flutter/material.dart';
import 'package:loantrack/apps/providers/loan_provider.dart';
import 'package:loantrack/apps/widgets/updateprofile.dart';
import 'package:loantrack/helpers/colors.dart';
import 'package:loantrack/widgets/common_widgets.dart';
import 'package:provider/provider.dart';

import '../helpers/styles.dart';

class LoanHealth extends StatefulWidget {
  const LoanHealth({Key? key}) : super(key: key);

  @override
  State<LoanHealth> createState() => _LoanHealthState();
}

class _LoanHealthState extends State<LoanHealth> {
  double health = -1;
  @override
  Widget build(BuildContext context) {
    double netIncome = context.read<LoanDetailsProviders>().netIncome;
    double currentLoanTotal = context.read<LoanDetailsProviders>().loanTotal;
    double repaidTotal = context.read<LoanDetailsProviders>().repaidTotal;
    String maritalStatus = context.read<LoanDetailsProviders>().maritalStatus;

    /* if (maritalStatus == '') {
      maritalStatus = 'Rather Not Say';
    }*/

    double incomeToLoanRatio = (netIncome / currentLoanTotal);
    double repaidToLoanRatio = (repaidTotal / currentLoanTotal);

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

    health = (marriedPercent + incomePercent + repaidPercent);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: screenHeight / 4 + 20),
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 24,
            ),
            child: (health < 0)
                ? Container(
                    height: screenHeight - 200,
                    width: screenWidth,
                    child: Center(
                      child: Column(
                        children: [
                          const Text(
                            'We do not have enough data to compute your loan health',
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
                                    color: (health >= 50 && health <= 100)
                                        ? LoanTrackColors2.TetiaryOne
                                            .withOpacity(.3)
                                        : (health >= 25 && health <= 49)
                                            ? LoanTrackColors.TetiaryOne
                                                .withOpacity(.3)
                                            : (health < 24 && health > -1)
                                                ? Colors.red.withOpacity(.3)
                                                : Colors.transparent,
                                  ),
                                ),
                                clipBehavior: Clip.hardEdge,
                                child: Container(
                                  color: (health >= 50 && health <= 100)
                                      ? LoanTrackColors2.TetiaryOne.withOpacity(
                                          .2)
                                      : (health >= 25 && health <= 49)
                                          ? LoanTrackColors.TetiaryOne
                                              .withOpacity(.2)
                                          : (health < 24 && health > -1)
                                              ? Colors.red.withOpacity(.2)
                                              : Colors.transparent,
                                  width: screenWidth / 2.5,
                                  height: (health / 100) *
                                      ((screenHeight / 2.5) / 2),
                                ),
                              ),
                              Container(
                                width: screenWidth / 2.5,
                                height: screenWidth / 2.5,
                                child: Center(
                                  child: Text(
                                    health.floor().toString(),
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: (health >= 50 && health <= 100)
                                          ? LoanTrackColors2.TetiaryOne
                                          : (health >= 25 && health <= 49)
                                              ? LoanTrackColors.TetiaryOne
                                              : (health < 24 && health > -1)
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
                                  'You are healthy',
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
                                    'Your loan health is fair. Consider keeping your borrowings below your net income.',
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
                                    'Seriously work towards paying off all loans before even considering any other loan.',
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
              horizontal: 24,
            ),
            height: screenHeight / 4,
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
                  'Health',
                  style: titleStyle(context),
                ),
                separatorSpace10,
                const Text(
                  'Welcome to Loan Health. Here you can see at a glance how well you are doing with your lending habits.',
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
