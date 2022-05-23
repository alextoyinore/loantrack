import 'package:flutter/material.dart';
import 'package:loantrack/apps/widgets/updateprofile.dart';
import 'package:loantrack/helpers/colors.dart';
import 'package:loantrack/widgets/common_widgets.dart';

class LoanHealth extends StatefulWidget {
  const LoanHealth({Key? key}) : super(key: key);

  @override
  State<LoanHealth> createState() => _LoanHealthState();
}

class _LoanHealthState extends State<LoanHealth> {
  double health = -1;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
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
                                  builder: (context) => const ProfileUpdate()));
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
            : Column(
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
                                      ? LoanTrackColors.TetiaryOne.withOpacity(
                                          .3)
                                      : (health < 24 && health > -1)
                                          ? Colors.red.withOpacity(.3)
                                          : Colors.transparent,
                            ),
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: Container(
                            color: (health >= 50 && health <= 100)
                                ? LoanTrackColors2.TetiaryOne.withOpacity(.2)
                                : (health >= 25 && health <= 49)
                                    ? LoanTrackColors.TetiaryOne.withOpacity(.2)
                                    : (health < 24 && health > -1)
                                        ? Colors.red.withOpacity(.2)
                                        : Colors.transparent,
                            width: screenWidth / 2.5,
                            height: (health / 100) * ((screenHeight / 2.5) / 2),
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
                                color: LoanTrackColors.PrimaryTwoVeryLight,
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
                              'Seriously consider paying off all loans before taking on any other loan.',
                              style: TextStyle(
                                color: LoanTrackColors.PrimaryTwoVeryLight,
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
    );
  }
}
