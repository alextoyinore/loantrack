import 'package:flutter/material.dart';
import 'package:loantrack/helpers/colors.dart';

class CreditScore extends StatefulWidget {
  const CreditScore({Key? key}) : super(key: key);

  @override
  State<CreditScore> createState() => _CreditScoreState();
}

class _CreditScoreState extends State<CreditScore> {
  @override
  double creditscore = 0;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        foregroundColor: LoanTrackColors.PrimaryOne,
        title: const Text('Credit Score'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 24,
        ),
        child: Column(
          children: [
            const Text(
              'Welcome to Creditscore. Here you can see at a glance how well you are doing with your credits.',
              softWrap: true,
              style: TextStyle(
                color: LoanTrackColors.PrimaryTwoVeryLight,
              ),
            ),
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
                        color: (creditscore >= 50 && creditscore <= 100)
                            ? LoanTrackColors2.TetiaryOne.withOpacity(.3)
                            : (creditscore >= 25 && creditscore <= 49)
                                ? LoanTrackColors.TetiaryOne.withOpacity(.3)
                                : (creditscore < 24)
                                    ? Colors.red.withOpacity(.3)
                                    : Colors.transparent,
                      ),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Container(
                      color: (creditscore >= 50 && creditscore <= 100)
                          ? LoanTrackColors2.TetiaryOne.withOpacity(.3)
                          : (creditscore >= 25 && creditscore <= 49)
                              ? LoanTrackColors.TetiaryOne.withOpacity(.3)
                              : (creditscore < 24)
                                  ? Colors.red.withOpacity(.3)
                                  : Colors.transparent,
                      width: screenWidth / 2.5,
                      height: (creditscore == 100)
                          ? (screenHeight / 2.5)
                          : creditscore,
                    ),
                  ),
                  Container(
                    width: screenWidth / 2.5,
                    height: screenWidth / 2.5,
                    child: Center(
                      child: Text(
                        creditscore.floor().toString(),
                        style: TextStyle(
                          fontSize: 30,
                          color: (creditscore >= 50 && creditscore <= 100)
                              ? LoanTrackColors2.TetiaryOne
                              : (creditscore >= 25 && creditscore <= 49)
                                  ? LoanTrackColors.TetiaryOne
                                  : (creditscore < 24)
                                      ? Colors.red
                                      : Colors.transparent,
                        ),
                      ),
                    ),
                  )
                ],
              )),
            )
          ],
        ),
      ),
    );
  }
}
