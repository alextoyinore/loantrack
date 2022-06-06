import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loantrack/helpers/colors.dart';
import 'package:loantrack/helpers/styles.dart';
import 'package:loantrack/widgets/common_widgets.dart';

import '../loan_record_app.dart';

class LoanDetail extends StatefulWidget {
  LoanDetail({Key? key, this.document}) : super(key: key);

  DocumentSnapshot? document;

  @override
  State<LoanDetail> createState() => _LoanDetailState();
}

class _LoanDetailState extends State<LoanDetail> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    DateTime dueWhen =
        DateTime.parse(widget.document!.get('dueWhen').toString());
    Duration duration = DateTime.now().difference(dueWhen);
    int due = duration.inDays;

    double progress = (widget.document!.get('amountRepaid') /
        widget.document!.get('loanAmount'));

    if (widget.document == null) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 250, horizontal: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/nodata.png', scale: 2),
              separatorSpace10,
              const Text(
                'Oops looks like there\'s nothing to see here. Perhaps you\'d like to take possession of this space...',
                style: TextStyle(color: LoanTrackColors.PrimaryTwoVeryLight),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      );
    }
    return Scaffold(
      body: Stack(children: [
        Container(
          height: 400,
        ),
        ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).colorScheme.background,
                  Colors.transparent,
                ]).createShader(Rect.fromLTRB(
              0,
              0,
              rect.width,
              rect.height,
            ));
          },
          blendMode: BlendMode.dstIn,
          child: Image.asset(
            'assets/images/loan.jpg',
            height: 300,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          height: screenHeight,
          padding: const EdgeInsets.only(left: 24.0, right: 24, top: 16),
          child: SingleChildScrollView(
            child: Column(children: [
              separatorSpace20,
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [Icon(Icons.close)],
                ),
              ),
              separatorSpace10,
              Text(
                '${widget.document!.get('lender').toString().toUpperCase()} - ${((widget.document!.get('loanAmount') - widget.document!.get('amountRepaid')) + (widget.document!.get('dailyOverdueCharge') * due)).toString()}',
                style: titleStyle(context),
              ),
              Row(
                children: [
                  OutlinedButton(
                    onPressed: () {
                      FirebaseFirestore.instance.collection('archive').add({
                        'userId': FirebaseAuth.instance.currentUser!.uid,
                        'loanId': widget.document!.id,
                        'loanAmount': widget.document!.get('loanAmount'),
                        'amountRepaid': widget.document!.get('amountRepaid'),
                        'interestRate': widget.document!.get('interestRate'),
                        'dailyOverdueCharge':
                            widget.document!.get('dailyOverdueCharge'),
                        'applyWhen': widget.document!.get('applyWhen'),
                        'dueWhen': widget.document!.get('dueWhen'),
                        'lastRepaidWhen': widget.document!.get('lastPaidWhen'),
                        'entryDate': widget.document!.get('entryDate'),
                        'modifiedWhen': widget.document!.get('modifiedWhen'),
                        'lenderType': widget.document!.get('lenderType'),
                        'lender': widget.document!.get('lender'),
                        'loanPurpose': widget.document!.get('loanPurpose'),
                        'note': widget.document!.get('note'),
                      }).whenComplete(
                        () => const SnackBar(
                          backgroundColor: LoanTrackColors.PrimaryOneVeryLight,
                          duration: Duration(milliseconds: 500),
                          content: Text('Loan record archived.'),
                        ),
                      );
                    },
                    child: Text('Archive'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  OutlinedButton(
                      onPressed: () {
                        FirebaseFirestore.instance.collection('archive').add({
                          'userId': FirebaseAuth.instance.currentUser!.uid,
                          'loanId': widget.document!.id,
                          'loanAmount': widget.document!.get('loanAmount'),
                          'amountRepaid': widget.document!.get('amountRepaid'),
                          'interestRate': widget.document!.get('interestRate'),
                          'dailyOverdueCharge':
                              widget.document!.get('dailyOverdueCharge'),
                          'applyWhen': widget.document!.get('applyWhen'),
                          'dueWhen': widget.document!.get('dueWhen'),
                          'lastRepaidWhen':
                              widget.document!.get('lastPaidWhen'),
                          'entryDate': widget.document!.get('entryDate'),
                          'modifiedWhen': widget.document!.get('modifiedWhen'),
                          'lenderType': widget.document!.get('lenderType'),
                          'lender': widget.document!.get('lender'),
                          'loanPurpose': widget.document!.get('loanPurpose'),
                          'note': widget.document!.get('note'),
                        }).whenComplete(
                          () => const SnackBar(
                            backgroundColor:
                                LoanTrackColors.PrimaryOneVeryLight,
                            duration: Duration(milliseconds: 500),
                            content: Text(
                              'Loan record archived.',
                              style: TextStyle(
                                color: LoanTrackColors.PrimaryOne,
                              ),
                            ),
                          ),
                        );
                        FirebaseFirestore.instance
                            .collection('loans')
                            .doc(widget.document!.id)
                            .delete();
                        Navigator.pop(context);
                      },
                      child: const Text('Delete')),
                  const SizedBox(
                    width: 10,
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    child: Text(
                      (due == 0)
                          ? 'DUE TODAY'
                          : (due > 0 && progress < 1)
                              ? '$due DAY(S) OVERDUE'
                              : (progress >= 1)
                                  ? 'PAID'
                                  : 'DUE IN $due DAYS',
                      style: TextStyle(
                        color: (due > 0 && progress < 1)
                            ? Theme.of(context).colorScheme.error
                            : Theme.of(context).colorScheme.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
              separatorSpace5,
              Row(
                children: [
                  (progress < 1)
                      ? OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoanRecord(
                                          documentSnapshot: widget.document,
                                          edit: false,
                                        )));
                          },
                          child: const Text('Add a repayment record'))
                      : const SizedBox(height: 0),
                  const SizedBox(
                    width: 10,
                  ),
                  OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoanRecord(
                                      documentSnapshot: widget.document,
                                      edit: true,
                                    )));
                      },
                      child: const Text('Edit this record')),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    separatorSpace20,

                    //Loan Amount
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Loan Amount', style: smallerTitleStyle(context)),
                        separatorSpace10,
                        Text(widget.document!.get('loanAmount').toString(),
                            style: smallTitleStyle(context))
                      ],
                    ),

                    separatorLine,
                    // Amount Repaid
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Amount Repaid',
                            style: smallerTitleStyle(context)),
                        separatorSpace10,
                        Text(widget.document!.get('amountRepaid').toString(),
                            style: smallTitleStyle(context))
                      ],
                    ),
                    separatorLine,
                    // Interest Rate
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Interest Rate',
                            style: smallerTitleStyle(context)),
                        separatorSpace10,
                        Text(widget.document!.get('interestRate').toString(),
                            style: smallTitleStyle(context))
                      ],
                    ),
                    separatorLine,
                    // Daily Overdue Charge
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Daily Overdue Charge',
                            style: smallerTitleStyle(context)),
                        separatorSpace10,
                        Text(
                            widget.document!
                                .get('dailyOverdueCharge')
                                .toString(),
                            style: smallTitleStyle(context))
                      ],
                    ),
                    separatorLine,
                    //Apply When
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Apply When', style: smallerTitleStyle(context)),
                        separatorSpace10,
                        Text(widget.document!.get('applyWhen').toString(),
                            style: smallTitleStyle(context))
                      ],
                    ),

                    separatorLine,
                    // Due When

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Due When', style: smallerTitleStyle(context)),
                        separatorSpace10,
                        Text(widget.document!.get('dueWhen').toString(),
                            style: smallTitleStyle(context))
                      ],
                    ),
                    separatorLine,
                    // Last Repayment Date
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Last Repayment Date',
                            style: smallerTitleStyle(context)),
                        separatorSpace10,
                        Text(widget.document!.get('lastPaidWhen').toString(),
                            style: smallTitleStyle(context))
                      ],
                    ),

                    separatorLine,
                    // Lender Type
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Lender Type', style: smallerTitleStyle(context)),
                        separatorSpace10,
                        Text(widget.document!.get('lenderType').toString(),
                            style: smallTitleStyle(context))
                      ],
                    ),

                    separatorLine,
                    // Lender
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Lender', style: smallerTitleStyle(context)),
                        separatorSpace10,
                        Text(widget.document!.get('lender').toString(),
                            style: smallTitleStyle(context))
                      ],
                    ),
                    separatorLine,

                    // Loan Purpose
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Loan Purpose', style: smallerTitleStyle(context)),
                        separatorSpace10,
                        Text(widget.document!.get('loanPurpose').toString(),
                            style: smallTitleStyle(context))
                      ],
                    ),

                    separatorLine,

                    //Note
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Note', style: smallerTitleStyle(context)),
                        separatorSpace10,
                        Text(
                          widget.document!.get('note').toString(),
                          style: bodyStyle(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              separatorSpace100,
            ]),
          ),
        )
      ]),
    );
  }
}
