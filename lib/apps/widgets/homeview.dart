import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loantrack/apps/widgets/button.dart';
import 'package:loantrack/helpers/colors.dart';
import 'package:loantrack/widgets/bulleted_list.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Stack(children: [
      SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 16, top: 16, right: 16),
          height: screenHeight,
          child: Column(children: [
            // Name and avatar
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
                        SizedBox(width: 5),
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
                    SizedBox(height: 5),
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
                Container(
                  alignment: Alignment.center,
                  clipBehavior: Clip.hardEdge,
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/images/user_profile.png'),
                      ),
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                          color: LoanTrackColors.PrimaryTwoVeryLight)),
                )
              ],
            ),

            SizedBox(height: 20),

            // Loan card
            Container(
              width: screenWidth,
              //height: screenHeight / 2.9,
              padding: EdgeInsets.only(top: 16, bottom: 16),
              decoration: BoxDecoration(
                color:
                    LoanTrackColors.PrimaryOne, //LoanTrackColors.PrimaryBlack,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 60,
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: ListView(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('CURRENT LOAN TOTAL',
                            style: const TextStyle(
                                color: LoanTrackColors.PrimaryOneVeryLight)),
                        SizedBox(height: 5),
                        StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('loans')
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
                                if (snapshot.data!.docs[i].get('userId') ==
                                    FirebaseAuth.instance.currentUser!.uid) {
                                  totalLoans += (double.parse(snapshot
                                          .data!.docs[i]
                                          .get('loanAmount')
                                          .toString()) -
                                      double.parse(snapshot.data!.docs[i]
                                          .get('amountRepaid')));
                                }
                              }
                              return (totalLoans > 0)
                                  ? Text('${totalLoans.toString()}',
                                      style: const TextStyle(
                                          fontSize: 36,
                                          color: LoanTrackColors
                                              .PrimaryOneVeryLight))
                                  : Text(
                                      '0.0',
                                      style: TextStyle(
                                          color: LoanTrackColors
                                              .PrimaryOneVeryLight),
                                    );
                            })
                      ],
                    ),
                  ),
                  Divider(
                      color:
                          LoanTrackColors.PrimaryOneVeryLight.withOpacity(.3),
                      thickness: 1),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 8.0, left: 16, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'TOP LOANERS',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: LoanTrackColors.PrimaryOneVeryLight,
                              fontSize: 16),
                        ),
                        SizedBox(height: 5),
                        Container(
                          height: 25,
                          padding: EdgeInsets.only(bottom: 5),
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('loans')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData)
                                return SpinKitThreeBounce(
                                  color: LoanTrackColors.PrimaryOneLight,
                                  size: 50,
                                );

                              return ListView.builder(
                                  itemCount: snapshot.data!.docs
                                      .length, //snapshot.data!.docs.length,
                                  controller: _controller,
                                  itemBuilder: (_, index) {
                                    if (snapshot.data!.docs[index]
                                            .get('userId') ==
                                        FirebaseAuth
                                            .instance.currentUser!.uid) {
                                      return Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 2),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            BulletedList(
                                              text:
                                                  '${snapshot.data!.docs[index].get('loaner').toUpperCase()} - ${snapshot.data!.docs[index].get('loanAmount')}',
                                              style: const TextStyle(
                                                  color: LoanTrackColors
                                                      .PrimaryOneLight),
                                            ),
                                            const Text('OVERDUE',
                                                style: TextStyle(
                                                    color: LoanTrackColors
                                                        .PrimaryOneLight))
                                          ],
                                        ),
                                      );
                                    }
                                    return const SizedBox(height: 0);
                                  });
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

            SizedBox(height: 20),
            Text(
              'Follow all your loans and track their progress here. Below is an overview of all your most recent loans.',
              style: TextStyle(color: LoanTrackColors.PrimaryTwoVeryLight),
            ),
            SizedBox(height: 5),

            // Tracking header
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'TRACKING',
                    style: TextStyle(color: LoanTrackColors.PrimaryTwoLight),
                  ),
                  Text(
                    'SEE ALL',
                    style: TextStyle(color: LoanTrackColors.PrimaryOne),
                  )
                ],
              ),
            ),

            // Loan Progress
            Container(
              width: screenWidth,
              height: screenHeight / 3,
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('loans')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const SpinKitThreeBounce(
                        color: LoanTrackColors.PrimaryOneLight,
                        size: 50,
                      );
                    }
                    return ListView.builder(
                      //padding: const EdgeInsets.only(bottom: 10),
                      itemCount: snapshot.data?.docs.length,
                      controller: _controller,
                      itemBuilder: (BuildContext context, int index) {
                        double progress = (double.parse(snapshot
                                .data!.docs[index]
                                .get('amountRepaid')
                                .toString()) /
                            double.parse(snapshot.data!.docs[index]
                                .get('loanAmount')
                                .toString()));
                        if (snapshot.data!.docs[index].get('userId') ==
                            FirebaseAuth.instance.currentUser!.uid) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 30.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(children: [
                                  Container(
                                    width: screenWidth * screenWidth,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      color: (progress >= 0.5)
                                          ? LoanTrackColors.PrimaryOneLight
                                          : LoanTrackColors.PrimaryTwoVeryLight,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  Container(
                                    width: screenWidth * progress,
                                    height: 5,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      snapshot.data!.docs[index]
                                              .get('loaner')
                                              .toUpperCase() +
                                          ' | LOAN: ' +
                                          snapshot.data!.docs[index]
                                              .get('loanAmount') +
                                          ' | REPAID: ' +
                                          snapshot.data!.docs[index]
                                              .get('amountRepaid')
                                              .toString(),
                                      style: const TextStyle(
                                          color:
                                              LoanTrackColors.PrimaryTwoLight,
                                          fontSize: 12),
                                    ),
                                    (progress == 1)
                                        ? const Text(
                                            'PAID',
                                            style: TextStyle(
                                                color:
                                                    LoanTrackColors.PrimaryOne,
                                                fontSize: 12),
                                          )
                                        : (progress == 0)
                                            ? const Text('UNPAID',
                                                style: const TextStyle(
                                                    color: LoanTrackColors
                                                        .PrimaryTwoLight,
                                                    fontSize: 12),
                                                softWrap: true)
                                            : Text(
                                                snapshot.data!.docs[index]
                                                    .get('lastPaidWhen'),
                                                style: const TextStyle(
                                                    color: LoanTrackColors
                                                        .PrimaryTwoLight,
                                                    fontSize: 12),
                                                softWrap: true),
                                  ],
                                )
                              ],
                            ),
                          );
                        } else {
                          return SizedBox(height: 0);
                        }
                      },
                    );
                  }),
            ),
          ]),
        ),
      ),

      // Action Buttons
      Positioned(
        bottom: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/repaymentRecord');
              },
              child: Container(
                  width: screenWidth / 2,
                  child: LoanTrackButton.primary(
                      context: context, label: 'New Payment Record')),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/loanRecord');
              },
              child: Container(
                width: screenWidth / 2,
                child: LoanTrackButton.secondaryOutline(
                    context: context, label: 'New Loan Record'),
              ),
            )
          ],
        ),
      )
    ]);
  }
}
