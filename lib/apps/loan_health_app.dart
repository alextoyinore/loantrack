import 'package:flutter/material.dart';
import 'package:loantrack/helpers/colors.dart';

class LoanHealth extends StatefulWidget {
  const LoanHealth({Key? key}) : super(key: key);

  @override
  State<LoanHealth> createState() => _LoanHealthState();
}

class _LoanHealthState extends State<LoanHealth> {
  double health = 0;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        foregroundColor: LoanTrackColors.PrimaryOne,
        title: const Text('Loan Health'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 24,
        ),
        child: Column(
          children: [
            const Text(
              'Welcome to Loan Health. Here you can see at a glance how well you are doing with your lending habits.',
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
                        color: (health >= 50 && health <= 100)
                            ? LoanTrackColors2.TetiaryOne.withOpacity(.3)
                            : (health >= 25 && health <= 49)
                                ? LoanTrackColors.TetiaryOne.withOpacity(.3)
                                : (health < 24)
                                    ? Colors.red.withOpacity(.3)
                                    : Colors.transparent,
                      ),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Container(
                      color: (health >= 50 && health <= 100)
                          ? LoanTrackColors2.TetiaryOne.withOpacity(.3)
                          : (health >= 25 && health <= 49)
                              ? LoanTrackColors.TetiaryOne.withOpacity(.3)
                              : (health < 24)
                                  ? Colors.red.withOpacity(.3)
                                  : Colors.transparent,
                      width: screenWidth / 2.5,
                      height: (health == 100) ? (screenHeight / 2.5) : health,
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
                                  : (health < 24)
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
