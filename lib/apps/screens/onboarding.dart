import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loantrack/apps/login_app.dart';
import 'package:loantrack/apps/widgets/button.dart';
import 'package:loantrack/widgets/common_widgets.dart';

import '../../data/applists.dart';
import '../../helpers/colors.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  PageController controller = PageController(initialPage: 0);
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              scrollDirection: Axis.vertical,
              controller: controller,
              itemCount: 3,
              itemBuilder: (_, index) {
                return Container(
                  padding: EdgeInsets.all(32),
                  height: screenHeight,
                  width: screenWidth,
                  margin: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: seed,
                    /*image: DecorationImage(
                      image: AssetImage(''),
                      fit: BoxFit.cover,
                    ),*/
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        separatorSpace100,
                        Image.asset(
                          'assets/images/ob${index + 1}.png',
                          scale: 10,
                          color: Colors.white,
                        ),
                        separatorSpace50,
                        Text(
                          AppLists.onboardingMessages[index],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }),
          (currentPage != 2)
              ? Positioned(
                  top: MediaQuery.of(context).size.height - 80,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Swipe up',
                          style: TextStyle(
                            color: Colors.white.withOpacity(.3),
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ))
              : SizedBox(
                  width: 0,
                  height: 0,
                ),
          Positioned(
              top: MediaQuery.of(context).size.height - 200,
              width: MediaQuery.of(context).size.width,
              child: (currentPage == 2)
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: LoanTrackButton.primary(
                        whenPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoanTrackLogin()));
                        },
                        label: 'Continue',
                        context: context,
                      ),
                    )
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 4,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(
                                3,
                                (index) => Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.white,
                                    ),
                                  ),
                                  child: (index == currentPage)
                                      ? AnimatedContainer(
                                          width: 15,
                                          height: 15,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          duration: Duration(milliseconds: 150),
                                        )
                                      : null,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))
        ],
      ),
    );
  }
}
