import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loantrack/apps/credit_score_app.dart';
import 'package:loantrack/apps/loan_advisor_app.dart';
import 'package:loantrack/apps/loan_compare_app.dart';
import 'package:loantrack/apps/loan_health_app.dart';
import 'package:loantrack/apps/loan_list_app.dart';
import 'package:loantrack/apps/news_app.dart';
import 'package:loantrack/helpers/colors.dart';
import 'package:loantrack/helpers/common_widgets.dart';

import '../../helpers/functions.dart';
import '../../widgets/application_grid_view.dart';
import '../../widgets/loan_track_modal.dart';
import 'button.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    String userId = FirebaseAuth.instance.currentUser!.uid;

    ScrollController sliderScrollController = ScrollController();

    return SingleChildScrollView(
      controller: _controller,
      child: Container(
        padding: const EdgeInsets.only(left: 24, top: 16, right: 24),
        //height: MediaQuery.of(context).size.height,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          //SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('Welcome,',
                          style: TextStyle(
                              fontSize: 16,
                              color: LoanTrackColors.PrimaryTwoLight)),
                      separatorSpace5,
                      Text(
                          FirebaseAuth.instance.currentUser!.displayName
                              .toString(),
                          //.toUpperCase(),
                          style: const TextStyle(
                              fontSize: 16,
                              //fontWeight: FontWeight.bold,
                              color: LoanTrackColors.PrimaryTwoLight)),
                    ],
                  ),
                  separatorSpace5,
                  Text(
                      Timestamp.now()
                          .toDate()
                          .toLocal()
                          .toString()
                          .substring(0, 16),
                      style: const TextStyle(
                        fontSize: 12,
                        color: LoanTrackColors.PrimaryTwoVeryLight,
                      )),
                ],
              ),
              const CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/images/user_profile.png'),
              ),
            ],
          ),
          separatorSpace20,

          // BEGIN LOAN CARD
          Container(
            width: screenWidth,
            //height: screenHeight / 2.9,
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            decoration: BoxDecoration(
              border: Border.all(
                  color: LoanTrackColors.PrimaryOne,
                  width: .5), //LoanTrackColors.PrimaryBlack,
              borderRadius: BorderRadius.circular(10),
              //color: LoanTrackColors2.TetiaryOneLight,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: screenHeight / 14,
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: ListView(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('CURRENT LOAN TOTAL',
                          style: TextStyle(color: LoanTrackColors.PrimaryOne)),
                      separatorSpace5,

                      // LOAN TOTAL STREAM

                      StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('loans')
                              .where('userId', isEqualTo: userId)
                              .snapshots(),
                          builder: (context, snapshot) {
                            double totalLoans = 0;
                            int len = 0;
                            if (snapshot.data?.docs.length != null) {
                              len = snapshot.data!.docs.length;
                            } else {
                              len = 0;
                            }

                            for (int i = 0; i < len; i++) {
                              DocumentSnapshot documentSnapshot =
                                  snapshot.data!.docs[i];

                              DateTime dueWhen = DateTime.parse(
                                  documentSnapshot.get('dueWhen').toString());
                              Duration duration =
                                  DateTime.now().difference(dueWhen);
                              int due = duration.inDays;

                              if (due <= 0) {
                                totalLoans +=
                                    (documentSnapshot.get('loanAmount') -
                                        documentSnapshot.get('amountRepaid'));
                              } else {
                                totalLoans += ((documentSnapshot
                                            .get('loanAmount') -
                                        documentSnapshot.get('amountRepaid')) +
                                    (documentSnapshot
                                            .get('dailyOverdueCharge') *
                                        due));
                              }
                            }
                            return (totalLoans > 0)
                                ? Text(totalLoans.toString(),
                                    style: const TextStyle(
                                        fontSize: 32,
                                        color: LoanTrackColors.PrimaryOne))
                                : const Text(
                                    '0.0',
                                    style: TextStyle(
                                        color: LoanTrackColors.PrimaryOne,
                                        fontSize: 32),
                                  );
                          })
                    ],
                  ),
                ),
                const Divider(color: LoanTrackColors.PrimaryOne, thickness: .5),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 16, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'TOP LENDERS',
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: LoanTrackColors
                                .PrimaryOne, //LoanTrackColors.PrimaryOneVeryLight,
                            fontSize: 12),
                      ),
                      separatorSpace5,
                      LoanBulletedList(
                          height: 25, numberOfItems: 5, userId: userId),
                    ],
                  ),
                )
              ],
            ),
          ),

          separatorSpace10,

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'NEW RECORD',
                  style: TextStyle(color: LoanTrackColors.PrimaryTwoLight),
                ),
                /*Text(
                      'SEE ALL',
                      style: TextStyle(color: LoanTrackColors.PrimaryOne),
                    )*/
              ],
            ),
          ),

          //SizedBox(height: 10),

          //BEGIN ACTION BUTTONS
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/loanRecord');
            },
            child: Container(
              child: LoanTrackButton.secondary(
                context: context,
                label: 'Add Loan Record',
              ),
            ),
          ),
          separatorSpace10,
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoanTrackingPage(
                            isHome: false,
                            loanListHeight: screenHeight * .7,
                          )));
            },
            child: Container(
                child: LoanTrackButton.primary(
              context: context,
              label: 'Add Repayment Record',
            )),
          ),
          separatorSpace10,
          GestureDetector(
            child: LoanTrackButton.primaryOutline(
                context: context, label: 'Compare Loan Offer'),
          ),

          //END ACTION BUTTONS

          // BEGIN LOAN PROGRESS

          separatorSpace20,

          // Progress header
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'TRACKING',
                  style: TextStyle(color: LoanTrackColors.PrimaryTwoLight),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoanTrackingPage(
                                  isHome: false,
                                  loanListHeight: screenHeight * .7,
                                )));
                  },
                  child: const Text(
                    'SEE ALL',
                    style: TextStyle(color: LoanTrackColors.PrimaryTwoLight),
                  ),
                )
              ],
            ),
          ),

          LoanList(
              width: screenWidth,
              height: screenHeight / 7,
              userId: userId,
              numberOfItems: 5),
          //END LOAN PROGRESS

          // BEGIN PRODUCT SLIDER

          //separatorSpace10,
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'POPULAR APPS',
                  style: TextStyle(color: LoanTrackColors.PrimaryTwoLight),
                ),
                GestureDetector(
                  onTap: () {
                    LoanTrackModal.modal(context,
                        content: const LoanTrackAppsGridView(),
                        title: 'Applications');
                  },
                  child: const Text(
                    'SEE ALL',
                    style: TextStyle(color: LoanTrackColors.PrimaryTwoLight),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 80,
            //padding: EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width,
            child: ListView(
              //padding: EdgeInsets.only(right: 10),
              controller: sliderScrollController,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoanAdvisor()));
                  },
                  child: const LoanTrackProductLinkBox(
                    icon: Icon(Icons.phone,
                        size: 25, color: LoanTrackColors2.PrimaryOneLight),
                    label: Text('ADVISOR',
                        style: TextStyle(
                            color: LoanTrackColors2.PrimaryOneLight,
                            fontSize: 11),
                        softWrap: true),
                    backgroundColor: LoanTrackColors2.PrimaryOneVeryLight,
                  ),
                ),
                horizontalSeparatorSpace20,
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoanHealth()));
                  },
                  child: const LoanTrackProductLinkBox(
                    icon: Icon(Icons.health_and_safety,
                        size: 25, color: LoanTrackColors.PrimaryOneLight),
                    label: Text('LOAN HEALTH',
                        style: TextStyle(
                            color: LoanTrackColors.PrimaryOneLight,
                            fontSize: 11),
                        textAlign: TextAlign.center,
                        softWrap: true),
                    backgroundColor: LoanTrackColors.PrimaryOneVeryLight,
                  ),
                ),
                horizontalSeparatorSpace20,
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NewsApp()));
                  },
                  child: const LoanTrackProductLinkBox(
                    icon: Icon(Icons.newspaper,
                        size: 25, color: LoanTrackColors2.TetiaryOne),
                    label: Text('NEWS',
                        style: TextStyle(
                            color: LoanTrackColors2.TetiaryOne, fontSize: 11),
                        textAlign: TextAlign.center,
                        softWrap: true),
                    backgroundColor: LoanTrackColors2.TetiaryOne,
                  ),
                ),
                horizontalSeparatorSpace20,
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CompareLoanOffer()));
                  },
                  child: const LoanTrackProductLinkBox(
                    icon: Icon(Icons.pattern,
                        size: 25, color: LoanTrackColors.PrimaryOne),
                    label: Text('LOAN PATTERN',
                        style: TextStyle(
                            color: LoanTrackColors.PrimaryOne, fontSize: 11),
                        textAlign: TextAlign.center,
                        softWrap: true),
                    backgroundColor: LoanTrackColors.PrimaryOne,
                  ),
                ),
                horizontalSeparatorSpace20,
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CreditScore()));
                  },
                  child: const LoanTrackProductLinkBox(
                    icon: Icon(Icons.numbers,
                        size: 25, color: LoanTrackColors2.PrimaryOne),
                    label: Text('CREDIT SCORE',
                        style: TextStyle(
                            color: LoanTrackColors2.PrimaryOne, fontSize: 11),
                        textAlign: TextAlign.center,
                        softWrap: true),
                    backgroundColor: LoanTrackColors2.PrimaryOne,
                  ),
                )
              ],
            ),
          ),
          //END PRODUCT SLIDER
          separatorSpace20,
        ]),
      ),
    );
  }
}

class LoanTrackProductLinkBox extends StatelessWidget {
  const LoanTrackProductLinkBox({
    Key? key,
    required this.icon,
    required this.label,
    required this.backgroundColor,
    this.whenTapped,
  }) : super(key: key);

  final Icon icon;
  final Widget label;
  final Function()? whenTapped;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    //double screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: whenTapped,
      borderRadius: BorderRadius.circular(10),
      //focusColor: LoanTrackColors2.PrimaryOneVeryLight,
      child: Container(
        width: screenHeight / 8,
        height: screenHeight / 10,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: backgroundColor.withOpacity(.1),
            borderRadius: BorderRadius.circular(10),
            border:
                Border.all(color: backgroundColor.withOpacity(.3), width: .5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                icon,
                separatorSpace5,
                label,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
