import 'package:flutter/material.dart';
import 'package:loantrack/apps/providers/loan_provider.dart';
import 'package:loantrack/apps/providers/preferences.dart';
import 'package:loantrack/apps/widgets/updateprofile.dart';
import 'package:loantrack/helpers/colors.dart';
import 'package:provider/provider.dart';

import '../helpers/styles.dart';
import '../widgets/common_widgets.dart';
import 'loan_record_app.dart';

class CreditScore extends StatefulWidget {
  const CreditScore({Key? key}) : super(key: key);

  @override
  State<CreditScore> createState() => _CreditScoreState();
}

class _CreditScoreState extends State<CreditScore> {
  @override
  double creditscore = -1;

  double totalMonthlyIncome = 0;
  String marital = '';
  Future<void> getUserData() async {
    AppPreferences prefs = AppPreferences();
    double monthlyIncome = await prefs.getMonthlyIncome();
    String married = await prefs.getMaritalStatus();
    setState(() {
      totalMonthlyIncome = monthlyIncome;
      marital = married;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double netIncome = totalMonthlyIncome;
    double currentLoanTotal = context.read<LoanDetailsProviders>().loanTotal;
    double repaidTotal = context.read<LoanDetailsProviders>().repaidTotal;
    String maritalStatus = marital;

    if (repaidTotal > 1 && currentLoanTotal <= 0) {
      repaidTotal = 1;
    }

    if (currentLoanTotal <= 0) {
      currentLoanTotal = 1;
      netIncome = 1;
    }

    if (repaidTotal <= 0) {
      repaidTotal = 1;
    }

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
    double incomePercent = incomeToLoanRatio * 40;
    double repaidPercent = repaidToLoanRatio * 50;

    creditscore = (marriedPercent + incomePercent + repaidPercent);

    if (creditscore.isNaN) {
      creditscore = -1;
    }

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
                      child: (currentLoanTotal > 0)
                          ? Column(
                              children: [
                                Text(
                                  'We do not have enough data to compute your loan Credit Score',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  ),
                                ),
                                separatorSpace10,
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ProfileUpdate()));
                                  },
                                  child: Text(
                                    'Update your profile now',
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                Text(
                                  'You need to have at least one loan record for us to compute your Credit Score',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  ),
                                ),
                                separatorSpace10,
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoanRecord(edit: false)));
                                  },
                                  child: Text(
                                    'Add a new loan record',
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
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
                                          .1)
                                      : (creditscore >= 25 && creditscore <= 49)
                                          ? LoanTrackColors.TetiaryOne
                                              .withOpacity(.1)
                                          : (creditscore < 24 &&
                                                  creditscore > -1)
                                              ? Colors.red.withOpacity(.1)
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
                                Text(
                                  'Your score is good',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
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
                                  child: Text(
                                    'Your Credit Score is at an average. Consider keeping your borrowings below your net income.',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
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
                                  child: Text(
                                    'Your score is bad. Seriously consider paying off all loans before taking on any other loan.',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
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
                Text(
                  'Welcome to Credit Score. Here you can see at a glance how viable you are for a loan. Your score will give you an idea of your chances of securing a loan.',
                  softWrap: true,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
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
