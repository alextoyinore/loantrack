import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:loantrack/apps/loan_record_app.dart';
import 'package:loantrack/apps/widgets/blogdetail.dart';
import 'package:loantrack/apps/widgets/button.dart';
import 'package:loantrack/apps/widgets/loandetail.dart';
import 'package:loantrack/apps/widgets/newsdetail.dart';
import 'package:loantrack/apps/widgets/updateprofile.dart';
import 'package:loantrack/data/applists.dart';
import 'package:loantrack/data/database.dart';
import 'package:loantrack/helpers/colors.dart';
import 'package:loantrack/helpers/styles.dart';
import 'package:loantrack/widgets/bulleted_list.dart';
import 'package:loantrack/widgets/common_widgets.dart';
import 'package:loantrack/widgets/dialogs.dart';
import 'package:loantrack/widgets/loan_track_modal.dart';
import 'package:loantrack/widgets/loan_track_textfield.dart';
import 'package:provider/provider.dart';

import '../apps/providers/loan_provider.dart';

SizedBox LoanList(
    {required double width,
    required double height,
    int? numberOfItems,
    required String userId}) {
  return SizedBox(
    width: width,
    height: height,
    child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('loans')
            .where('userId', isEqualTo: userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
                child: Text(
              'No data',
              style: TextStyle(
                  fontSize: 14, color: LoanTrackColors.PrimaryTwoVeryLight),
            ));
          }
          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'No data',
                style: TextStyle(
                    fontSize: 14, color: LoanTrackColors.PrimaryTwoVeryLight),
              ),
            );
          }
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 3,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              itemCount: (numberOfItems != null &&
                      numberOfItems > 0 &&
                      numberOfItems <= snapshot.data!.docs.length)
                  ? numberOfItems
                  : snapshot.data?.docs.length,
              shrinkWrap: true,
              //controller: _controller,
              itemBuilder: (BuildContext context, int index) {
                DocumentSnapshot document = snapshot.data!.docs[index];
                double progress =
                    document.get('amountRepaid') / document.get('loanAmount');
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoanDetail(
                                  document: document,
                                )));
                  },
                  onLongPress: () {
                    LoanTrackModal.modal(
                      context,
                      height: MediaQuery.of(context).size.height / 2.5,
                      content: Container(
                        child: Column(
                            children: List.generate(
                                AppLists.loanListOptionItem.length,
                                (index) => GestureDetector(
                                      onTap: () {
                                        switch (index) {
                                          case 0:
                                            Navigator.push(
                                                context,
                                                CupertinoPageRoute(
                                                    builder: (context) =>
                                                        LoanDetail(
                                                          document: document,
                                                        )));
                                            // Navigator.pop(context);
                                            break;
                                          case 1:
                                            Navigator.push(
                                                context,
                                                CupertinoPageRoute(
                                                    builder: (context) =>
                                                        LoanRecord(
                                                          edit: false,
                                                          documentSnapshot:
                                                              document,
                                                        )));
                                            //Navigator.pop(context);
                                            break;
                                          case 2:
                                            Navigator.push(
                                                context,
                                                CupertinoPageRoute(
                                                    builder: (context) =>
                                                        LoanRecord(
                                                          edit: true,
                                                          documentSnapshot:
                                                              document,
                                                        )));
                                            //Navigator.pop(context);
                                            break;
                                          case 3:
                                            FirebaseFirestore.instance
                                                .collection('archive')
                                                .add({
                                              'userId': FirebaseAuth
                                                  .instance.currentUser!.uid,
                                              'loanId': document.id,
                                              'loanAmount':
                                                  document.get('loanAmount'),
                                              'amountRepaid':
                                                  document.get('amountRepaid'),
                                              'interestRate':
                                                  document.get('interestRate'),
                                              'dailyOverdueCharge': document
                                                  .get('dailyOverdueCharge'),
                                              'applyWhen':
                                                  document.get('applyWhen'),
                                              'dueWhen':
                                                  document.get('dueWhen'),
                                              'lastRepaidWhen':
                                                  document.get('lastPaidWhen'),
                                              'entryDate':
                                                  document.get('entryDate'),
                                              'modifiedWhen':
                                                  document.get('modifiedWhen'),
                                              'lenderType':
                                                  document.get('lenderType'),
                                              'lender': document.get('lender'),
                                              'loanPurpose':
                                                  document.get('loanPurpose'),
                                              'note': document.get('note'),
                                            }).whenComplete(
                                              () => const SnackBar(
                                                backgroundColor: LoanTrackColors
                                                    .PrimaryOneVeryLight,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                content: Text(
                                                    'Loan record archived.'),
                                              ),
                                            );
                                            // Navigator.pop(context);
                                            break;
                                          case 4:
                                            FirebaseFirestore.instance
                                                .collection('archive')
                                                .add({
                                              'userId': FirebaseAuth
                                                  .instance.currentUser!.uid,
                                              'loanId': document.id,
                                              'loanAmount':
                                                  document.get('loanAmount'),
                                              'amountRepaid':
                                                  document.get('amountRepaid'),
                                              'interestRate':
                                                  document.get('interestRate'),
                                              'dailyOverdueCharge': document
                                                  .get('dailyOverdueCharge'),
                                              'applyWhen':
                                                  document.get('applyWhen'),
                                              'dueWhen':
                                                  document.get('dueWhen'),
                                              'lastRepaidWhen':
                                                  document.get('lastPaidWhen'),
                                              'entryDate':
                                                  document.get('entryDate'),
                                              'modifiedWhen':
                                                  document.get('modifiedWhen'),
                                              'lenderType':
                                                  document.get('lenderType'),
                                              'lender': document.get('lender'),
                                              'loanPurpose':
                                                  document.get('loanPurpose'),
                                              'note': document.get('note'),
                                            }).whenComplete(
                                              () => const SnackBar(
                                                backgroundColor: LoanTrackColors
                                                    .PrimaryOneVeryLight,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                content: Text(
                                                    'Loan record archived.'),
                                              ),
                                            );
                                            FirebaseFirestore.instance
                                                .collection('loans')
                                                .doc(document.id)
                                                .delete();
                                          // Navigator.pop(context);
                                          //break;
                                        }
                                      },
                                      child: ListTile(
                                        title: Text(
                                          AppLists.loanListOptionItem[index],
                                          style: const TextStyle(
                                            color: LoanTrackColors
                                                .PrimaryTwoVeryLight,
                                          ),
                                        ),
                                      ),
                                    ))),
                      ),
                      title: 'Options',
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(.05),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10.0,
                            left: 10,
                            right: 10,
                          ),
                          child: Text(
                            snapshot.data!.docs[index]
                                .get('lender')
                                .toUpperCase(),
                            style: sectionHeaderStyle(context),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Loan Balance',
                            style: smallerDescriptionStyle(context),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            (snapshot.data!.docs[index].get('loanAmount') -
                                    snapshot.data!.docs[index]
                                        .get('amountRepaid'))
                                .toString(),
                            style: featureTitleStyle(context),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Amount Repaid',
                            style: smallerDescriptionStyle(context),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            snapshot.data!.docs[index]
                                .get('amountRepaid')
                                .toString(),
                            style: smallerTitleStyle(context),
                          ),
                        ),
                        (progress >= 1)
                            ? const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Text(
                                  'PAID',
                                  style: TextStyle(
                                      color: LoanTrackColors.PrimaryOne,
                                      fontSize: 12),
                                ),
                              )
                            : (progress == 0)
                                ? const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Text('UNPAID',
                                        style: TextStyle(
                                            color: LoanTrackColors2.PrimaryOne,
                                            fontSize: 12),
                                        softWrap: true),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Text(
                                        snapshot.data!.docs[index]
                                            .get('lastPaidWhen'),
                                        style: const TextStyle(
                                            color: LoanTrackColors2.PrimaryOne,
                                            fontSize: 12),
                                        softWrap: true),
                                  ),
                        Stack(children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: 4,
                            decoration: BoxDecoration(
                              color: (progress >= 0.5)
                                  ? Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(.1)
                                  : Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(.05),
                              borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width /
                                2 *
                                progress,
                            height: 4,
                            decoration: BoxDecoration(
                              color: (progress >= 0.5)
                                  ? Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(.5)
                                  : Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(.5),
                              borderRadius: BorderRadius.only(
                                bottomRight: (progress >= 1)
                                    ? const Radius.circular(10)
                                    : const Radius.circular(0),
                                bottomLeft: const Radius.circular(10),
                              ),
                            ),
                          ),
                        ]),
                      ],
                    ),
                  ),
                );
              });
        }),
  );
}

// BEGIN LOAN SLIDER

SizedBox LoanSlider(
    {required double width,
    required double height,
    int? numberOfItems,
    required String userId}) {
  return SizedBox(
    width: width,
    height: height,
    child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('loans')
            .where('userId', isEqualTo: userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
                child: Text(
              'No data',
              style: TextStyle(
                  fontSize: 14, color: LoanTrackColors.PrimaryTwoVeryLight),
            ));
          }
          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'No data',
                style: TextStyle(
                    fontSize: 14, color: LoanTrackColors.PrimaryTwoVeryLight),
              ),
            );
          }
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: (numberOfItems != null &&
                      numberOfItems > 0 &&
                      numberOfItems <= snapshot.data!.docs.length)
                  ? numberOfItems
                  : snapshot.data?.docs.length,
              shrinkWrap: true,
              //controller: _controller,
              itemBuilder: (BuildContext context, int index) {
                DocumentSnapshot document = snapshot.data!.docs[index];
                double progress =
                    document.get('amountRepaid') / document.get('loanAmount');
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoanDetail(
                                  document: document,
                                )));
                  },
                  onLongPress: () {
                    LoanTrackModal.modal(
                      context,
                      height: MediaQuery.of(context).size.height / 2.5,
                      content: Container(
                        child: Column(
                            children: List.generate(
                                AppLists.loanListOptionItem.length,
                                (index) => GestureDetector(
                                      onTap: () {
                                        switch (index) {
                                          case 0:
                                            Navigator.push(
                                                context,
                                                CupertinoPageRoute(
                                                    builder: (context) =>
                                                        LoanDetail(
                                                          document: document,
                                                        )));
                                            // Navigator.pop(context);
                                            break;
                                          case 1:
                                            Navigator.push(
                                                context,
                                                CupertinoPageRoute(
                                                    builder: (context) =>
                                                        LoanRecord(
                                                          edit: false,
                                                          documentSnapshot:
                                                              document,
                                                        )));
                                            //Navigator.pop(context);
                                            break;
                                          case 2:
                                            Navigator.push(
                                                context,
                                                CupertinoPageRoute(
                                                    builder: (context) =>
                                                        LoanRecord(
                                                          edit: true,
                                                          documentSnapshot:
                                                              document,
                                                        )));
                                            //Navigator.pop(context);
                                            break;
                                          case 3:
                                            FirebaseFirestore.instance
                                                .collection('archive')
                                                .add({
                                              'userId': FirebaseAuth
                                                  .instance.currentUser!.uid,
                                              'loanId': document.id,
                                              'loanAmount':
                                                  document.get('loanAmount'),
                                              'amountRepaid':
                                                  document.get('amountRepaid'),
                                              'interestRate':
                                                  document.get('interestRate'),
                                              'dailyOverdueCharge': document
                                                  .get('dailyOverdueCharge'),
                                              'applyWhen':
                                                  document.get('applyWhen'),
                                              'dueWhen':
                                                  document.get('dueWhen'),
                                              'lastRepaidWhen':
                                                  document.get('lastPaidWhen'),
                                              'entryDate':
                                                  document.get('entryDate'),
                                              'modifiedWhen':
                                                  document.get('modifiedWhen'),
                                              'lenderType':
                                                  document.get('lenderType'),
                                              'lender': document.get('lender'),
                                              'loanPurpose':
                                                  document.get('loanPurpose'),
                                              'note': document.get('note'),
                                            }).whenComplete(
                                              () => const SnackBar(
                                                backgroundColor: LoanTrackColors
                                                    .PrimaryOneVeryLight,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                content: Text(
                                                    'Loan record archived.'),
                                              ),
                                            );
                                            // Navigator.pop(context);
                                            break;
                                          case 4:
                                            FirebaseFirestore.instance
                                                .collection('archive')
                                                .add({
                                              'userId': FirebaseAuth
                                                  .instance.currentUser!.uid,
                                              'loanId': document.id,
                                              'loanAmount':
                                                  document.get('loanAmount'),
                                              'amountRepaid':
                                                  document.get('amountRepaid'),
                                              'interestRate':
                                                  document.get('interestRate'),
                                              'dailyOverdueCharge': document
                                                  .get('dailyOverdueCharge'),
                                              'applyWhen':
                                                  document.get('applyWhen'),
                                              'dueWhen':
                                                  document.get('dueWhen'),
                                              'lastRepaidWhen':
                                                  document.get('lastPaidWhen'),
                                              'entryDate':
                                                  document.get('entryDate'),
                                              'modifiedWhen':
                                                  document.get('modifiedWhen'),
                                              'lenderType':
                                                  document.get('lenderType'),
                                              'lender': document.get('lender'),
                                              'loanPurpose':
                                                  document.get('loanPurpose'),
                                              'note': document.get('note'),
                                            }).whenComplete(
                                              () => const SnackBar(
                                                backgroundColor: LoanTrackColors
                                                    .PrimaryOneVeryLight,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                content: Text(
                                                    'Loan record archived.'),
                                              ),
                                            );
                                            FirebaseFirestore.instance
                                                .collection('loans')
                                                .doc(document.id)
                                                .delete();
                                          // Navigator.pop(context);
                                          //break;
                                        }
                                      },
                                      child: ListTile(
                                        title: Text(
                                          AppLists.loanListOptionItem[index],
                                          style: const TextStyle(
                                            color: LoanTrackColors
                                                .PrimaryTwoVeryLight,
                                          ),
                                        ),
                                      ),
                                    ))),
                      ),
                      title: 'Options',
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2.4,
                    margin: const EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(.05),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10.0,
                            left: 10,
                            right: 10,
                          ),
                          child: Text(
                            snapshot.data!.docs[index]
                                .get('lender')
                                .toUpperCase(),
                            style: sectionHeaderStyle(context),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Loan Balance',
                            style: smallerDescriptionStyle(context),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            (snapshot.data!.docs[index].get('loanAmount') -
                                    snapshot.data!.docs[index]
                                        .get('amountRepaid'))
                                .toString(),
                            style: featureTitleStyle(context),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Amount Repaid',
                            style: smallerDescriptionStyle(context),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            snapshot.data!.docs[index]
                                .get('amountRepaid')
                                .toString(),
                            style: smallerTitleStyle(context),
                          ),
                        ),
                        (progress >= 1)
                            ? const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Text(
                                  'PAID',
                                  style: TextStyle(
                                      color: LoanTrackColors.PrimaryOne,
                                      fontSize: 12),
                                ),
                              )
                            : (progress == 0)
                                ? const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Text('UNPAID',
                                        style: TextStyle(
                                            color: LoanTrackColors2.PrimaryOne,
                                            fontSize: 12),
                                        softWrap: true),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Text(
                                        snapshot.data!.docs[index]
                                            .get('lastPaidWhen'),
                                        style: const TextStyle(
                                            color: LoanTrackColors2.PrimaryOne,
                                            fontSize: 12),
                                        softWrap: true),
                                  ),
                        Stack(children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: 6,
                            decoration: BoxDecoration(
                              color: (progress >= 0.5)
                                  ? Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(.1)
                                  : Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(.05),
                              borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width /
                                2 *
                                progress,
                            height: 6,
                            decoration: BoxDecoration(
                              color: (progress >= 0.5)
                                  ? Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(.3)
                                  : Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(.1),
                              borderRadius: BorderRadius.only(
                                bottomRight: (progress >= 1)
                                    ? const Radius.circular(10)
                                    : const Radius.circular(0),
                                bottomLeft: const Radius.circular(10),
                              ),
                            ),
                          ),
                        ]),
                      ],
                    ),
                  ),
                );
              });
        }),
  );
}

// END LOAN SLIDER

Container LoanBulletedList({
  required double height,
  int? numberOfItems,
  required String userId,
}) {
  ScrollController _controller = ScrollController();
  return Container(
    height: height,
    padding: const EdgeInsets.only(bottom: 5),
    child: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('loans')
          .where('userId', isEqualTo: userId)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Text(
              'No data',
              style: smallDescriptionStyle(context),
            ),
          );
        }

        if (snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text(
              'No data',
              style: smallDescriptionStyle(context),
            ),
          );
        }

        return ListView.builder(
            itemCount: (numberOfItems != null &&
                    numberOfItems > 0 &&
                    numberOfItems <= snapshot.data!.docs.length)
                ? numberOfItems
                : snapshot.data?.docs.length, //snapshot.data!.docs.length,
            controller: _controller,
            itemBuilder: (_, index) {
              DocumentSnapshot document = snapshot.data!.docs[index];

              DateTime dueWhen =
                  DateTime.parse(document.get('dueWhen').toString());
              Duration duration = DateTime.now().difference(dueWhen);
              int due = duration.inDays;

              if (snapshot.data!.docs[index].get('userId') ==
                  FirebaseAuth.instance.currentUser!.uid) {
                return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return LoanDetail(
                              document: snapshot.data!.docs[index]);
                        }));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BulletedList(
                            text:
                                '${snapshot.data!.docs[index].get('lender').toUpperCase()} - ${((snapshot.data!.docs[index].get('loanAmount') - document.get('amountRepaid') + (due * document.get('dailyOverdueCharge')))).toString()}',
                            style: smallerTitleStyle(context),
                          ),
                          (due > 0)
                              ? Text(
                                  '$due DAYS OVERDUE',
                                  style: smallerTitleStyle(context),
                                )
                              : (due == 0)
                                  ? Text(
                                      'DUE TODAY',
                                      style: smallerTitleStyle(context),
                                    )
                                  : Text(
                                      '',
                                      style: smallerTitleStyle(context),
                                    )
                        ],
                      ),
                    ));
              }
              return const SizedBox(height: 0);
            });
      },
    ),
  );
}

Container RepaymentBulletedList(
    {required double height,
    int? numberOfItems,
    required String userId,
    String? loanId}) {
  ScrollController _controller = ScrollController();
  return Container(
    height: height,
    padding: const EdgeInsets.only(bottom: 5),
    child: StreamBuilder<QuerySnapshot>(
      stream: (loanId != null)
          ? FirebaseFirestore.instance
              .collection('repayments')
              .where('userId', isEqualTo: userId)
              .where('loanId', isEqualTo: loanId)
              .snapshots()
          : FirebaseFirestore.instance
              .collection('repayments')
              .where('userId', isEqualTo: userId)
              .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
              child: Text(
            'No data',
            style: TextStyle(fontSize: 14, color: LoanTrackColors.PrimaryOne),
          ));
        }

        if (snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text(
              'No data',
              style: TextStyle(fontSize: 14, color: LoanTrackColors.PrimaryOne),
            ),
          );
        }

        return ListView.builder(
            itemCount: (numberOfItems != null &&
                    numberOfItems > 0 &&
                    numberOfItems <= snapshot.data!.docs.length)
                ? numberOfItems
                : snapshot.data?.docs.length, //snapshot.data!.docs.length,
            controller: _controller,
            itemBuilder: (_, index) {
              DocumentSnapshot document = snapshot.data!.docs[index];

              return Container(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) {
                      //   return LoanDetail(document: document.get('loanId'));
                      // }));
                    },
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: BulletedList(
                                text: document
                                    .get('repaidWhen')
                                    .toString()
                                    .toUpperCase(),
                                style: const TextStyle(
                                    color: LoanTrackColors.PrimaryOne),
                              ),
                            ),
                            Text(document.get('amountRepaid').toString(),
                                style: const TextStyle(
                                    color: LoanTrackColors.PrimaryOne)),
                            GestureDetector(
                                onTap: () {
                                  FirebaseFirestore.instance
                                      .collection('repayments')
                                      .doc(document.id)
                                      .delete();
                                },
                                child: const Icon(
                                  Icons.delete_outline,
                                  size: 20,
                                  color: LoanTrackColors.PrimaryTwoVeryLight,
                                ))
                          ],
                        ),
                        (index < snapshot.data!.docs.length - 1 ||
                                (numberOfItems != null &&
                                    index < numberOfItems - 1))
                            ? separatorLine
                            : const SizedBox(height: 0),
                      ],
                    ),
                  ));
            });
      },
    ),
  );
}

SizedBox BlogList({required double height}) {
  ScrollController controller = ScrollController();
  DatabaseService db = DatabaseService();
  return SizedBox(
    height: height,
    child: StreamBuilder<QuerySnapshot>(
      stream: db.blog.snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
              child: Text(
            'No data',
            style: TextStyle(
                fontSize: 14, color: LoanTrackColors.PrimaryTwoVeryLight),
          ));
        }

        if (snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text(
              'No data',
              style: TextStyle(
                  fontSize: 14, color: LoanTrackColors.PrimaryTwoVeryLight),
            ),
          );
        }
        return ListView.builder(
          itemCount: (snapshot.hasData) ? snapshot.data!.docs.length : 0,
          controller: controller,
          itemBuilder: (context, index) {
            DocumentSnapshot blogDocument = snapshot.data!.docs[index];

            if (blogDocument.get('featuredImage') != null &&
                blogDocument.get('title') != null &&
                blogDocument.get('content') != null &&
                blogDocument.get('category') != null &&
                blogDocument.get('whenPublished') != null) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => BlogDetail(
                              blog: blogDocument,
                            )),
                  );
                },
                child: Container(
                  height: MediaQuery.of(context).size.height / 2.2,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  //decoration: BoxDecoration(color: Colors.white, boxShadow: []),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 100, //MediaQuery.of(context).size.height / 8,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            image: DecorationImage(
                              image: NetworkImage(
                                  blogDocument.get('featuredImage')),
                              fit: BoxFit.cover,
                            )),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          color:
                              LoanTrackColors.PrimaryTwoVeryLight.withOpacity(
                                  .1),
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                blogDocument.get('title').toString(),
                                style: smallTitleStyle(context),
                              ),
                              separatorSpace10,
                              Text(
                                  blogDocument
                                          .get('content')
                                          .toString()
                                          .replaceAll('<p>', '')
                                          .replaceAll('</p>', '')
                                          .substring(0, 150) +
                                      '...',
                                  style: descriptionStyle(context),
                                  softWrap: true),
                              separatorSpace10,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    blogDocument
                                        .get('category')
                                        .toString()
                                        .toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color:
                                          LoanTrackColors.PrimaryTwoVeryLight,
                                    ),
                                  ),
                                  Text(
                                    blogDocument
                                        .get('whenPublished')
                                        .toString(),
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: LoanTrackColors
                                            .PrimaryTwoVeryLight),
                                  ),
                                ],
                              ),
                            ]),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return const SizedBox(height: 0);
            }
          },
        );
      },
    ),
  );
}

SizedBox NewsList({required double height}) {
  ScrollController controller = ScrollController();
  DatabaseService db = DatabaseService();
  return SizedBox(
    height: height,
    child: StreamBuilder<QuerySnapshot>(
      stream: db.news.snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
              child: Text(
            'No data',
            style: TextStyle(
                fontSize: 14, color: LoanTrackColors.PrimaryTwoVeryLight),
          ));
        }

        if (snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text(
              'No data',
              style: TextStyle(
                  fontSize: 14, color: LoanTrackColors.PrimaryTwoVeryLight),
            ),
          );
        }
        return ListView.builder(
          itemCount: (snapshot.hasData) ? snapshot.data!.docs.length : 0,
          controller: controller,
          itemBuilder: (context, index) {
            DocumentSnapshot newsDocument = snapshot.data!.docs[index];

            if (newsDocument.get('featuredImage') != null &&
                newsDocument.get('title') != null &&
                newsDocument.get('excerpt') != null &&
                newsDocument.get('source') != null &&
                newsDocument.get('whenPublished') != null) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => NewsDetail(
                              news: newsDocument,
                            )),
                  );
                },
                child: Container(
                  height: MediaQuery.of(context).size.height / 2.2,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  //decoration: BoxDecoration(color: Colors.white, boxShadow: []),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 100, //MediaQuery.of(context).size.height / 8,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            image: DecorationImage(
                              image: NetworkImage(
                                  newsDocument.get('featuredImage')),
                              fit: BoxFit.cover,
                            )),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          color:
                              LoanTrackColors.PrimaryTwoVeryLight.withOpacity(
                                  .1),
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                newsDocument.get('title').toString(),
                                style: smallTitleStyle(context),
                              ),
                              separatorSpace10,
                              Text(
                                  newsDocument
                                          .get('excerpt')
                                          .toString()
                                          .replaceAll('<p>', '')
                                          .replaceAll('</p>', '')
                                          .substring(0, 150) +
                                      '...',
                                  style: descriptionStyle(context),
                                  softWrap: true),
                              separatorSpace10,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    newsDocument
                                        .get('source')
                                        .toString()
                                        .toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color:
                                          LoanTrackColors.PrimaryTwoVeryLight,
                                    ),
                                  ),
                                  Text(
                                    newsDocument
                                        .get('whenPublished')
                                        .toString(),
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: LoanTrackColors
                                            .PrimaryTwoVeryLight),
                                  ),
                                ],
                              ),
                            ]),
                      )
                    ],
                  ),
                ),
              );
            }
            return const SizedBox(height: 0);
          },
        );
      },
    ),
  );
}

SizedBox userProfile({double? height}) {
  DatabaseService db = DatabaseService();
  return SizedBox(
    height: height,
    child: StreamBuilder<QuerySnapshot>(
        stream: db.users
            .where(
              'userId',
              isEqualTo: db.userId,
            )
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: Text(
              'No data',
              style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onBackground),
            ));
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Column(
                children: [
                  Text(
                    'You haven\'t updated your profile yet.',
                    style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const ProfileUpdate(),
                          ));
                    },
                    child: Text(
                      'Update your profile now',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  )
                ],
              ),
            );
          }

          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot user = snapshot.data!.docs[index];
                double netIncome = double.parse(user.get('totalMonthlyIncome'));
                String maritalStatus = user.get('married') ?? '';

                // Add net income to provider
                context.read<LoanDetailsProviders>().setNetIncome(netIncome);
                // Add maritalStatus to provider
                context
                    .read<LoanDetailsProviders>()
                    .setMaritalStatus(maritalStatus);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Full name
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 8.0,
                      ),
                      /* color:
                          LoanTrackColors.PrimaryTwoVeryLight.withOpacity(.1), */
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name: ',
                            style: descriptionStyle(context),
                            softWrap: true,
                          ),
                          GestureDetector(
                            onTap: () {
                              TextEditingController firstnameController =
                                  TextEditingController();
                              TextEditingController lastnameController =
                                  TextEditingController();
                              LoanTrackModal.modal(
                                context,
                                /*  height:
                                    MediaQuery.of(context).size.height / 1.2, */
                                content: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 2,
                                  child: Column(
                                    children: [
                                      LoanTrackTextField(
                                          controller: firstnameController,
                                          label: 'First Name',
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground),
                                      separatorSpace10,
                                      LoanTrackTextField(
                                          controller: lastnameController,
                                          label: 'Last Name',
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground),
                                      separatorSpace10,
                                      GestureDetector(
                                        onTap: () {
                                          FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(user.id)
                                              .update({
                                                'firstname':
                                                    firstnameController.text,
                                                'lastname':
                                                    lastnameController.text,
                                              })
                                              .whenComplete(() => {
                                                    showSuccessDialog(
                                                        context: context,
                                                        title: 'Success',
                                                        successMessage:
                                                            'You have successfully updated your first name and last name',
                                                        whenTapped: () {
                                                          Navigator.pop(
                                                              context);
                                                        })
                                                  })
                                              .onError((error, stackTrace) => {
                                                    showErrorDialog(
                                                        context: context,
                                                        title: 'Error',
                                                        errorMessage:
                                                            'An error occurred while updating your first name and last name'),
                                                  });
                                          Navigator.pop(context);
                                        },
                                        child: LoanTrackButton.primary(
                                            whenPressed: () {},
                                            context: context,
                                            label: 'Continue'),
                                      ),
                                    ],
                                  ),
                                ),
                                title: 'Edit Names',
                              );
                            },
                            child: Text(
                              '${user.get('firstname')} ${user.get('lastname')}',
                              style: bigBodyStyle(context),
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                    ),

                    separatorSpace10,

                    // Age
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 8,
                      ),
                      /*  color:
                          LoanTrackColors.PrimaryTwoVeryLight.withOpacity(.1), */
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Age:',
                            style: TextStyle(
                                color: LoanTrackColors.PrimaryTwoVeryLight),
                          ),
                          GestureDetector(
                            onTap: () {
                              TextEditingController ageController =
                                  TextEditingController();

                              LoanTrackModal.modal(
                                context,
                                height:
                                    MediaQuery.of(context).size.height / 1.2,
                                content: Container(
                                  child: Column(
                                    children: [
                                      LoanTrackTextField(
                                          controller: ageController,
                                          keyboardType: const TextInputType
                                              .numberWithOptions(),
                                          label: 'Age',
                                          color: LoanTrackColors
                                                  .PrimaryTwoVeryLight
                                              .withOpacity(.1)),
                                      separatorSpace10,
                                      GestureDetector(
                                        onTap: () {
                                          FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(user.id)
                                              .update({
                                                'age': ageController.text,
                                              })
                                              .whenComplete(() => {
                                                    showSuccessDialog(
                                                        context: context,
                                                        title: 'Success',
                                                        successMessage:
                                                            'You have successfully updated your age',
                                                        whenTapped: () {
                                                          Navigator.pop(
                                                              context);
                                                        })
                                                  })
                                              .onError((error, stackTrace) => {
                                                    showErrorDialog(
                                                        context: context,
                                                        title: 'Error',
                                                        errorMessage:
                                                            'An error occured while updating your age'),
                                                  });
                                          Navigator.pop(context);
                                        },
                                        child: LoanTrackButton.primary(
                                            whenPressed: () {},
                                            context: context,
                                            label: 'Continue'),
                                      ),
                                    ],
                                  ),
                                ),
                                title: 'Edit Age',
                              );
                            },
                            child: Text(
                              '${user.get('age')}',
                              style: bigBodyStyle(context),
                            ),
                          ),
                        ],
                      ),
                    ),

                    separatorSpace10,

                    //Gender
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 8,
                      ),
                      /* color:
                          LoanTrackColors.PrimaryTwoVeryLight.withOpacity(.1), */
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Gender:',
                            style: TextStyle(
                                color: LoanTrackColors.PrimaryTwoVeryLight),
                          ),
                          GestureDetector(
                            onTap: () {
                              LoanTrackModal.modal(context,
                                  content: Column(
                                    children: List.generate(
                                        AppLists.genders.length,
                                        (index) => GestureDetector(
                                              onTap: () {
                                                FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(user.id)
                                                    .update({
                                                      'gender': AppLists
                                                          .genders[index],
                                                    })
                                                    .whenComplete(() => {
                                                          showSuccessDialog(
                                                              context: context,
                                                              title: 'Success',
                                                              successMessage:
                                                                  'You have successfully updated your gender detail',
                                                              whenTapped: () {
                                                                Navigator.pop(
                                                                    context);
                                                              })
                                                        })
                                                    .onError((error,
                                                            stackTrace) =>
                                                        {
                                                          showErrorDialog(
                                                              context: context,
                                                              title: 'Failed',
                                                              errorMessage:
                                                                  'An error occured while updating your gender details')
                                                        });

                                                Navigator.pop(context);
                                              },
                                              child: ListTile(
                                                title: Text(
                                                  AppLists.genders[index],
                                                  style: const TextStyle(
                                                    color: LoanTrackColors
                                                        .PrimaryTwoVeryLight,
                                                  ),
                                                ),
                                              ),
                                            )),
                                  ),
                                  title: 'Edit Gender');
                            },
                            child: Text('${user.get('gender')}',
                                style: bigBodyStyle(context)),
                          ),
                        ],
                      ),
                    ),
                    separatorSpace10,

                    //Occupation
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 8,
                      ),
                      /* color:
                          LoanTrackColors.PrimaryTwoVeryLight.withOpacity(.1), */
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Occupation:',
                            style: TextStyle(
                                color: LoanTrackColors.PrimaryTwoVeryLight),
                          ),
                          GestureDetector(
                            onTap: () {
                              TextEditingController occupationController =
                                  TextEditingController();

                              LoanTrackModal.modal(
                                context,
                                height:
                                    MediaQuery.of(context).size.height / 1.2,
                                content: Container(
                                  child: Column(
                                    children: [
                                      LoanTrackTextField(
                                          controller: occupationController,
                                          label: 'Occupation',
                                          color: LoanTrackColors
                                                  .PrimaryTwoVeryLight
                                              .withOpacity(.1)),
                                      separatorSpace10,
                                      GestureDetector(
                                        onTap: () {
                                          FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(user.id)
                                              .update({
                                                'occupation':
                                                    occupationController.text,
                                              })
                                              .whenComplete(() => {
                                                    showSuccessDialog(
                                                        context: context,
                                                        title: 'Success',
                                                        successMessage:
                                                            'You have successfully updated your occupation',
                                                        whenTapped: () {
                                                          Navigator.pop(
                                                              context);
                                                        })
                                                  })
                                              .onError((error, stackTrace) => {
                                                    showErrorDialog(
                                                        context: context,
                                                        title: 'Error',
                                                        errorMessage:
                                                            'An error occured while updating your occupation details'),
                                                  });
                                          Navigator.pop(context);
                                        },
                                        child: LoanTrackButton.primary(
                                            whenPressed: () {},
                                            context: context,
                                            label: 'Continue'),
                                      ),
                                    ],
                                  ),
                                ),
                                title: 'Edit Occupation',
                              );
                            },
                            child: Text('${user.get('occupation')}',
                                style: bigBodyStyle(context)),
                          ),
                        ],
                      ),
                    ),
                    separatorSpace10,

                    //Industry
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 8,
                      ),
                      /* color:
                          LoanTrackColors.PrimaryTwoVeryLight.withOpacity(.1), */
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Industry:',
                            style: TextStyle(
                                color: LoanTrackColors.PrimaryTwoVeryLight),
                          ),
                          GestureDetector(
                            onTap: () {
                              LoanTrackModal.modal(context,
                                  content: Column(
                                    children: List.generate(
                                        AppLists.occupationIndustry.length,
                                        (index) => GestureDetector(
                                              onTap: () {
                                                FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(user.id)
                                                    .update({
                                                      'industry': AppLists
                                                              .occupationIndustry[
                                                          index],
                                                    })
                                                    .whenComplete(() => {
                                                          showSuccessDialog(
                                                              context: context,
                                                              title: 'Success',
                                                              successMessage:
                                                                  'You have successfully updated your occupation industry',
                                                              whenTapped: () {
                                                                Navigator.pop(
                                                                    context);
                                                              })
                                                        })
                                                    .onError((error,
                                                            stackTrace) =>
                                                        {
                                                          showErrorDialog(
                                                              context: context,
                                                              title: 'Error',
                                                              errorMessage:
                                                                  'An error occured while updating your occupation industry details')
                                                        });

                                                Navigator.pop(context);
                                              },
                                              child: ListTile(
                                                title: Text(
                                                  AppLists.occupationIndustry[
                                                      index],
                                                  style: const TextStyle(
                                                    color: LoanTrackColors
                                                        .PrimaryTwoVeryLight,
                                                  ),
                                                ),
                                              ),
                                            )),
                                  ),
                                  title: 'Edit Industry');
                            },
                            child: Text(
                              '${user.get('industry')}',
                              style: bigBodyStyle(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                    separatorSpace10,
                    // Age
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 8,
                      ),
                      /* color:
                          LoanTrackColors.PrimaryTwoVeryLight.withOpacity(.1), */
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Total Monthly Income:',
                            style: TextStyle(
                                color: LoanTrackColors.PrimaryTwoVeryLight),
                          ),
                          GestureDetector(
                            onTap: () {
                              TextEditingController monthlyController =
                                  TextEditingController();

                              LoanTrackModal.modal(
                                context,
                                height:
                                    MediaQuery.of(context).size.height / 1.2,
                                content: Container(
                                  child: Column(
                                    children: [
                                      LoanTrackTextField(
                                          controller: monthlyController,
                                          keyboardType: const TextInputType
                                              .numberWithOptions(),
                                          label: 'Total Monthly Income',
                                          color: LoanTrackColors
                                                  .PrimaryTwoVeryLight
                                              .withOpacity(.1)),
                                      separatorSpace10,
                                      GestureDetector(
                                        onTap: () {
                                          FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(user.id)
                                              .update({
                                                'totalMonthlyIncome':
                                                    monthlyController.text,
                                              })
                                              .whenComplete(() => {
                                                    showSuccessDialog(
                                                        context: context,
                                                        title: 'Success',
                                                        successMessage:
                                                            'You have successfully updated your monthly income',
                                                        whenTapped: () {
                                                          Navigator.pop(
                                                              context);
                                                        })
                                                  })
                                              .onError((error, stackTrace) => {
                                                    showErrorDialog(
                                                        context: context,
                                                        title: 'Error',
                                                        errorMessage:
                                                            'An error occured while updating your monthly income'),
                                                  });
                                          Navigator.pop(context);
                                        },
                                        child: LoanTrackButton.primary(
                                            whenPressed: () {},
                                            context: context,
                                            label: 'Continue'),
                                      ),
                                    ],
                                  ),
                                ),
                                title: 'Edit Monthly Income',
                              );
                            },
                            child: Text(
                              '${user.get('totalMonthlyIncome')}',
                              style: bigBodyStyle(context),
                            ),
                          ),
                        ],
                      ),
                    ),

                    separatorSpace10,

                    //Country of Residence
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 8,
                      ),
                      /* color:
                          LoanTrackColors.PrimaryTwoVeryLight.withOpacity(.1), */
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Country of Residence:',
                            style: TextStyle(
                                color: LoanTrackColors.PrimaryTwoVeryLight),
                          ),
                          GestureDetector(
                            onTap: () {
                              LoanTrackModal.modal(context,
                                  content: Column(
                                    children: List.generate(
                                        AppLists.countries.length,
                                        (index) => GestureDetector(
                                              onTap: () {
                                                FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(user.id)
                                                    .update({
                                                      'countryOfResidence':
                                                          AppLists
                                                              .countries[index],
                                                    })
                                                    .whenComplete(() => {
                                                          showSuccessDialog(
                                                              context: context,
                                                              title: 'Success',
                                                              successMessage:
                                                                  'You have successfully updated your gender detail',
                                                              whenTapped: () {
                                                                Navigator.pop(
                                                                    context);
                                                              })
                                                        })
                                                    .onError((error,
                                                            stackTrace) =>
                                                        {
                                                          showErrorDialog(
                                                              context: context,
                                                              title: 'Error',
                                                              errorMessage:
                                                                  'An error occured while updating your gender details')
                                                        });

                                                Navigator.pop(context);
                                              },
                                              child: ListTile(
                                                title: Text(
                                                  AppLists.countries[index],
                                                  style: const TextStyle(
                                                    color: LoanTrackColors
                                                        .PrimaryTwoVeryLight,
                                                  ),
                                                ),
                                              ),
                                            )),
                                  ),
                                  title: 'Edit Residence Country');
                            },
                            child: Text('${user.get('countryOfResidence')}',
                                style: bigBodyStyle(context)),
                          ),
                        ],
                      ),
                    ),

                    separatorSpace10,

                    //Gender
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 8,
                      ),
                      /* color:
                          LoanTrackColors.PrimaryTwoVeryLight.withOpacity(.1), */
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'City of Residence:',
                            style: TextStyle(
                                color: LoanTrackColors.PrimaryTwoVeryLight),
                          ),
                          GestureDetector(
                            onTap: () {
                              LoanTrackModal.modal(context,
                                  content: Column(
                                    children: List.generate(
                                        AppLists.cities.length,
                                        (index) => GestureDetector(
                                              onTap: () {
                                                FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(user.id)
                                                    .update({
                                                      'cityOfResidence':
                                                          AppLists
                                                              .cities[index],
                                                    })
                                                    .whenComplete(() => {
                                                          showSuccessDialog(
                                                              context: context,
                                                              title: 'Success',
                                                              successMessage:
                                                                  'You have successfully updated your city of residence',
                                                              whenTapped: () {
                                                                Navigator.pop(
                                                                    context);
                                                              })
                                                        })
                                                    .onError((error,
                                                            stackTrace) =>
                                                        {
                                                          showErrorDialog(
                                                              context: context,
                                                              title: 'Error',
                                                              errorMessage:
                                                                  'An error occured while updating your city of residence')
                                                        });

                                                Navigator.pop(context);
                                              },
                                              child: ListTile(
                                                title: Text(
                                                  AppLists.cities[index],
                                                  style: const TextStyle(
                                                    color: LoanTrackColors
                                                        .PrimaryTwoVeryLight,
                                                  ),
                                                ),
                                              ),
                                            )),
                                  ),
                                  title: 'Edit City');
                            },
                            child: Text(
                              '${user.get('cityOfResidence')}',
                              style: bigBodyStyle(context),
                            ),
                          ),
                        ],
                      ),
                    ),

                    separatorSpace10,

                    //Nationality
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 8,
                      ),
                      /* color:
                          LoanTrackColors.PrimaryTwoVeryLight.withOpacity(.1), */
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Nationality:',
                            style: TextStyle(
                                color: LoanTrackColors.PrimaryTwoVeryLight),
                          ),
                          GestureDetector(
                            onTap: () {
                              LoanTrackModal.modal(context,
                                  content: Column(
                                    children: List.generate(
                                        AppLists.countries.length,
                                        (index) => GestureDetector(
                                              onTap: () {
                                                FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(user.id)
                                                    .update({
                                                      'nationality': AppLists
                                                          .countries[index],
                                                    })
                                                    .whenComplete(() => {
                                                          showSuccessDialog(
                                                              context: context,
                                                              title: 'Success',
                                                              successMessage:
                                                                  'You have successfully updated your nationality',
                                                              whenTapped: () {
                                                                Navigator.pop(
                                                                    context);
                                                              })
                                                        })
                                                    .onError((error,
                                                            stackTrace) =>
                                                        {
                                                          showErrorDialog(
                                                              context: context,
                                                              title: 'Failed',
                                                              errorMessage:
                                                                  'An error occurred while updating your nationality')
                                                        });

                                                Navigator.pop(context);
                                              },
                                              child: ListTile(
                                                title: Text(
                                                  AppLists.countries[index],
                                                  style: const TextStyle(
                                                    color: LoanTrackColors
                                                        .PrimaryTwoVeryLight,
                                                  ),
                                                ),
                                              ),
                                            )),
                                  ),
                                  title: 'Edit Gender');
                            },
                            child: Text('${user.get('nationality')}',
                                style: bigBodyStyle(context)),
                          ),
                        ],
                      ),
                    ),

                    separatorSpace10,

                    //Nationality
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 8,
                      ),
                      /* color:
                          LoanTrackColors.PrimaryTwoVeryLight.withOpacity(.1), */
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'I\'m a Samaritan:',
                            style: TextStyle(
                                color: LoanTrackColors.PrimaryTwoVeryLight),
                          ),
                          GestureDetector(
                            onTap: () {
                              LoanTrackModal.modal(context,
                                  /* height:
                                      MediaQuery.of(context).size.height / 4, */
                                  content: Column(
                                    children: List.generate(
                                        AppLists.yesNo.length,
                                        (index) => GestureDetector(
                                              onTap: () {
                                                FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(user.id)
                                                    .update({
                                                      'isSamaritan':
                                                          AppLists.yesNo[index],
                                                    })
                                                    .whenComplete(() => {
                                                          showSuccessDialog(
                                                              context: context,
                                                              title: 'Success',
                                                              successMessage:
                                                                  'You have successfully updated your Samaritan status',
                                                              whenTapped: () {
                                                                Navigator.pop(
                                                                    context);
                                                              })
                                                        })
                                                    .onError((error,
                                                            stackTrace) =>
                                                        {
                                                          showErrorDialog(
                                                              context: context,
                                                              title: 'Failed',
                                                              errorMessage:
                                                                  'An error occured while updating your Samaritan status')
                                                        });

                                                Navigator.pop(context);
                                              },
                                              child: ListTile(
                                                title: Text(
                                                  AppLists.yesNo[index],
                                                  style: const TextStyle(
                                                    color: LoanTrackColors
                                                        .PrimaryTwoVeryLight,
                                                  ),
                                                ),
                                              ),
                                            )),
                                  ),
                                  title: 'Edit Samaritan Status');
                            },
                            child: Text(
                              '${user.get('isSamaritan')}',
                              style: bigBodyStyle(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                    separatorSpace10,
                  ],
                );
              });
        }),
  );
}
