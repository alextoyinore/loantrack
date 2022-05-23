import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loantrack/apps/widgets/text_button.dart';
import 'package:loantrack/helpers/colors.dart';
import 'package:loantrack/widgets/common_widgets.dart';

import '../helpers/listwidgets.dart';

class LoanTrackingPage extends StatefulWidget {
  LoanTrackingPage(
      {Key? key,
      required this.loanListHeight,
      this.numberOfItems,
      required this.isHome})
      : super(key: key);

  double loanListHeight;
  bool isHome;
  int? numberOfItems;

  @override
  State<LoanTrackingPage> createState() => _LoanTrackingPageState();
}

class _LoanTrackingPageState extends State<LoanTrackingPage> {
  double totalRepaid = 0;
  double totalInLoan = 0;

  String userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return (!widget.isHome)
        ? Scaffold(
            body: Container(
            padding: const EdgeInsets.only(top: 24.0, left: 24, right: 24),
            margin: const EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('LOAN LIST',
                    style: TextStyle(color: LoanTrackColors.PrimaryTwoLight)),
                separatorSpace20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Total repaid Box
                    Container(
                      width: screenWidth / 2.35,
                      height: screenHeight / 12,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 0),
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: seed,
                      )),
                      child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'TOTAL REPAID',
                            style: TextStyle(
                              color: seed,
                            ),
                          ),
                          StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('loans')
                                  .where('userId', isEqualTo: userId)
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
                                  totalRepaid += (snapshot.data!.docs[i]
                                      .get('amountRepaid'));
                                }
                                return (totalRepaid > 0)
                                    ? Text(totalRepaid.toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: seed,
                                        ))
                                    : const Text(
                                        '0.0',
                                        style: TextStyle(
                                            color: seed, fontSize: 20),
                                      );
                              })
                        ],
                      ),
                    ),

                    //Total Loan owed Box
                    Container(
                      width: screenWidth / 2.35,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 0),
                      height: screenHeight / 12,
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: LoanTrackColors2.PrimaryOne,
                      )),
                      child: Column(
                        children: [
                          const Text('CURRENT LOAN TOTAL',
                              style: TextStyle(
                                  color: LoanTrackColors2.PrimaryOne)),
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

                                  DateTime dueWhen = DateTime.parse(snapshot
                                      .data!.docs[i]
                                      .get('dueWhen')
                                      .toString());
                                  Duration duration =
                                      DateTime.now().difference(dueWhen);
                                  int due = duration.inDays;

                                  if (due <= 0) {
                                    totalLoans += (documentSnapshot
                                            .get('loanAmount') -
                                        documentSnapshot.get('amountRepaid'));
                                  } else {
                                    totalLoans +=
                                        ((documentSnapshot.get('loanAmount') -
                                                documentSnapshot
                                                    .get('amountRepaid')) +
                                            (documentSnapshot
                                                    .get('dailyOverdueCharge') *
                                                due));
                                  }
                                }
                                return (totalLoans > 0)
                                    ? Text('$totalLoans',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: LoanTrackColors2.PrimaryOne,
                                        ))
                                    : const Text(
                                        '0.0',
                                        style: TextStyle(
                                            color: LoanTrackColors2.PrimaryOne,
                                            fontSize: 20),
                                      );
                              }),
                        ],
                      ),
                    )
                  ],
                ),
                separatorSpace20,
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
                      label: 'Lender',
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

                separatorSpace20,

                const Text(
                  'Select a loan from the list to \'Edit\' or \'Make Repayment\' ',
                  style: TextStyle(color: LoanTrackColors.PrimaryTwoVeryLight),
                ),

                //Loan list
                SingleChildScrollView(
                  child: LoanList(
                      userId: userId,
                      width: screenWidth,
                      height: (widget.loanListHeight > 0)
                          ? widget.loanListHeight
                          : screenHeight * .7),
                ),
                separatorSpace10,
              ],
            ),
          ))
        : Container(
            padding: const EdgeInsets.only(top: 32.0, left: 24, right: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('LOAN LIST',
                    style: TextStyle(color: LoanTrackColors.PrimaryTwoLight)),
                separatorSpace10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Total repaid Box
                    Container(
                      width: screenWidth / 2.35,
                      height: MediaQuery.of(context).size.height / 12,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 0),
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: seed,
                      )),
                      child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'TOTAL REPAID',
                            style: TextStyle(
                              color: seed,
                            ),
                          ),
                          StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('loans')
                                  .where('userId', isEqualTo: userId)
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
                                  totalRepaid += (snapshot.data!.docs[i]
                                      .get('amountRepaid'));
                                }
                                return (totalRepaid > 0)
                                    ? Text(totalRepaid.toString(),
                                        style: const TextStyle(
                                          color: seed,
                                          fontSize: 20,
                                        ))
                                    : const Text(
                                        '0.0',
                                        style: TextStyle(
                                            color: seed, fontSize: 20),
                                      );
                              })
                        ],
                      ),
                    ),

                    //Total Loan owed Box
                    Container(
                      width: screenWidth / 2.35,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 0),
                      height: MediaQuery.of(context).size.height / 12,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: LoanTrackColors2.PrimaryOne)),
                      child: Column(
                        children: [
                          const Text('CURRENT LOAN TOTAL',
                              style: TextStyle(
                                  color: LoanTrackColors2.PrimaryOne)),
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

                                  DateTime dueWhen = DateTime.parse(snapshot
                                      .data!.docs[i]
                                      .get('dueWhen')
                                      .toString());
                                  Duration duration =
                                      DateTime.now().difference(dueWhen);
                                  int due = duration.inDays;

                                  if (due <= 0) {
                                    totalLoans += (documentSnapshot
                                            .get('loanAmount') -
                                        documentSnapshot.get('amountRepaid'));
                                  } else {
                                    totalLoans +=
                                        ((documentSnapshot.get('loanAmount') -
                                                documentSnapshot
                                                    .get('amountRepaid')) +
                                            (documentSnapshot
                                                    .get('dailyOverdueCharge') *
                                                due));
                                  }
                                }
                                return (totalLoans > 0)
                                    ? Text(totalLoans.toString(),
                                        style: const TextStyle(
                                            fontSize: 20,
                                            color: LoanTrackColors2.PrimaryOne))
                                    : const Text(
                                        '0.0',
                                        style: TextStyle(
                                            color: LoanTrackColors2.PrimaryOne,
                                            fontSize: 20),
                                      );
                              }),
                        ],
                      ),
                    )
                  ],
                ),
                separatorSpace20,
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
                      label: 'Lender',
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
                separatorSpace10,

                //Loan list
                SingleChildScrollView(
                  child: LoanList(
                      userId: userId,
                      width: screenWidth,
                      height: (widget.loanListHeight > 0)
                          ? widget.loanListHeight
                          : screenHeight / 1.76),
                ),
                separatorSpace10,
              ],
            ),
          );
  }
}
