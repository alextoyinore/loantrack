import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loantrack/apps/widgets/text_button.dart';
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
              // Total repaid Box
              Container(
                width: screenWidth / 2.3,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: LoanTrackColors.PrimaryOne)),
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'TOTAL REPAID',
                      style: TextStyle(color: LoanTrackColors.PrimaryOne),
                    ),
                    StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('loans')
                            .snapshots(),
                        builder: (context, snapshot) {
                          double totalRepaid = 0;
                          int len = 0;
                          if (snapshot.data?.docs.length != null) {
                            len = snapshot.data!.docs.length;
                          } else {
                            len = 0;
                          }
                          for (int i = 0; i < len; i++) {
                            if (snapshot.data!.docs[i].get('userId') ==
                                FirebaseAuth.instance.currentUser!.uid) {
                              totalRepaid += (double.parse(snapshot
                                  .data!.docs[i]
                                  .get('amountRepaid')
                                  .toString()));
                            }
                          }
                          return (totalRepaid > 0)
                              ? Text('${totalRepaid.toString()}',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: LoanTrackColors.PrimaryOne))
                              : const Text(
                                  '0.0',
                                  style: TextStyle(
                                      color:
                                          LoanTrackColors.PrimaryOneVeryLight),
                                );
                        })
                  ],
                ),
              ),

              //Total Loan owed Box
              Container(
                width: screenWidth / 2.3,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: LoanTrackColors.PrimaryTwoLight)),
                child: Column(
                  children: [
                    const Text('TOTAL IN LOAN',
                        style:
                            TextStyle(color: LoanTrackColors.PrimaryTwoLight)),
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
                              totalLoans += (double.parse(snapshot.data!.docs[i]
                                      .get('loanAmount')
                                      .toString()) -
                                  double.parse(snapshot.data!.docs[i]
                                      .get('amountRepaid')));
                            }
                          }
                          return (totalLoans > 0)
                              ? Text('${totalLoans.toString()}',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: LoanTrackColors.PrimaryTwo))
                              : const Text(
                                  '0.0',
                                  style: TextStyle(
                                      color: LoanTrackColors.PrimaryTwo),
                                );
                        })
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

          //Loan list
          SingleChildScrollView(
            child: Container(
              width: screenWidth,
              height: screenHeight / 1.61,
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
                      //controller: _controller,
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
          ),
        ],
      ),
    );
  }
}
