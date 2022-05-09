import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loantrack/apps/loan_record_app.dart';
import 'package:loantrack/apps/widgets/button.dart';
import 'package:loantrack/helpers/colors.dart';
import 'package:loantrack/helpers/common_widgets.dart';
import 'package:loantrack/helpers/styles.dart';

class LoanDetail extends StatefulWidget {
  LoanDetail({Key? key, this.document}) : super(key: key);

  DocumentSnapshot? document;

  @override
  State<LoanDetail> createState() => _LoanDetailState();
}

class _LoanDetailState extends State<LoanDetail> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
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
      backgroundColor: Colors.white,
      body: Stack(children: [
        Container(
          height: screenHeight,
          padding: const EdgeInsets.only(left: 24.0, right: 24, top: 16),
          child: SingleChildScrollView(
            child: Column(children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: screenHeight / 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.archive_outlined,
                          color: LoanTrackColors2.PrimaryOne,
                        ),
                        Text(
                          '${widget.document!.get('lender').toString().toUpperCase()} - ${((widget.document!.get('loanAmount') - widget.document!.get('amountRepaid')) + (widget.document!.get('dailyOverdueCharge') * due)).toString()}',
                          style: const TextStyle(
                              color: LoanTrackColors.PrimaryTwoLight),
                        ),
                        GestureDetector(
                          onTap: () {
                            FirebaseFirestore.instance
                                .collection('loans')
                                .doc(widget.document!.id)
                                .delete();
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.delete_outline,
                            color: LoanTrackColors2.PrimaryOneLight,
                          ),
                        ),
                      ],
                    ),
                    separatorSpace40,
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: (due > 0 && progress < 1)
                                ? LoanTrackColors2.PrimaryOneLight
                                : LoanTrackColors.PrimaryOne),
                      ),
                      child: Text(
                        (due == 0)
                            ? 'DUE TODAY'
                            : (due > 0 && progress < 1)
                                ? '$due DAY(S) OVERDUE'
                                : (progress >= 1)
                                    ? 'PAID'
                                    : 'SAFE',
                        style: TextStyle(
                            color: (due > 0 && progress < 1)
                                ? LoanTrackColors2.PrimaryOneLight
                                : LoanTrackColors.PrimaryOne),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    separatorSpace20,

                    //Loan Amount
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Loan Amount', style: detailStyle),
                        Text(widget.document!.get('loanAmount').toString(),
                            style: detailStyle)
                      ],
                    ),

                    separatorLine,
                    // Amount Repaid
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Amount Repaid', style: detailStyle),
                        Text(widget.document!.get('amountRepaid').toString(),
                            style: detailStyle)
                      ],
                    ),
                    separatorLine,
                    // Interest Rate
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Interest Rate', style: detailStyle),
                        Text(widget.document!.get('interestRate').toString(),
                            style: detailStyle)
                      ],
                    ),
                    separatorLine,
                    // Daily Overdue Charge
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Daily Overdue Charge', style: detailStyle),
                        Text(
                            widget.document!
                                .get('dailyOverdueCharge')
                                .toString(),
                            style: detailStyle)
                      ],
                    ),
                    separatorLine,
                    //Apply When
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Apply When', style: detailStyle),
                        Text(widget.document!.get('applyWhen').toString(),
                            style: detailStyle)
                      ],
                    ),

                    separatorLine,
                    // Due When

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Due When', style: detailStyle),
                        Text(widget.document!.get('dueWhen').toString(),
                            style: detailStyle)
                      ],
                    ),
                    separatorLine,
                    // Last Repayment Date
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Last Repayment Date', style: detailStyle),
                        Text(widget.document!.get('lastPaidWhen').toString(),
                            style: detailStyle)
                      ],
                    ),

                    separatorLine,
                    // Lender Type
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Lender Type', style: detailStyle),
                        Text(widget.document!.get('lenderType').toString(),
                            style: detailStyle)
                      ],
                    ),

                    separatorLine,
                    // Lender
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Lender', style: detailStyle),
                        Text(widget.document!.get('lender').toString(),
                            style: detailStyle)
                      ],
                    ),
                    separatorLine,

                    // Loan Purpose
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Loan Purpose', style: detailStyle),
                        Text(widget.document!.get('loanPurpose').toString(),
                            style: detailStyle)
                      ],
                    ),

                    separatorLine,

                    //Note
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Note', style: detailStyle),
                        Container(
                            width: MediaQuery.of(context).size.width / 2.25,
                            child: Text(widget.document!.get('note').toString(),
                                textAlign: TextAlign.right, style: detailStyle))
                      ],
                    ),
                    separatorSpace40,
                    (progress < 1)
                        ? GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoanRecord(
                                            documentSnapshot: widget.document,
                                            edit: false,
                                          )));
                            },
                            child: Container(
                                //width: screenWidth,
                                child: LoanTrackButton.primaryOutline(
                                    context: context,
                                    label: 'Add a repayment record')),
                          )
                        : const SizedBox(height: 0),
                    separatorSpace20,
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoanRecord(
                                      documentSnapshot: widget.document,
                                      edit: true,
                                    )));
                      },
                      child: Container(
                          //width: screenWidth,
                          child: LoanTrackButton.secondaryOutline(
                              context: context, label: 'Edit this record')),
                    ),
                    separatorSpace20,
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          //width: screenWidth,
                          child: LoanTrackButton.secondaryOutline(
                              context: context, label: 'Cancel')),
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
