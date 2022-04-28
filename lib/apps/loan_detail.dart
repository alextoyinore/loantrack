import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loantrack/apps/new_repayment_record.dart';
import 'package:loantrack/apps/widgets/button.dart';
import 'package:loantrack/helpers/colors.dart';

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

    if (widget.document == null) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 250, horizontal: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/nodata.png', scale: 2),
              SizedBox(height: 10),
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
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Icon(
              Icons.archive_outlined,
              color: LoanTrackColors2.PrimaryOne,
            )),
        title: Column(
          children: [
            Text(
              '${widget.document!.get('lender').toString().toUpperCase()} - ${((widget.document!.get('loanAmount') - widget.document!.get('amountRepaid')) + (widget.document!.get('dailyOverdueCharge') * due)).toString()}',
              style: TextStyle(color: LoanTrackColors.PrimaryTwoLight),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(top: 0, right: 24),
            child: GestureDetector(
              onTap: () {
                FirebaseFirestore.instance
                    .collection('loans')
                    .doc(widget.document!.id)
                    .delete();
                Navigator.pop(context);
              },
              child: Icon(
                Icons.delete_outline,
                color: LoanTrackColors.PrimaryOneLight,
              ),
            ),
          )
        ],
      ),
      body: Stack(children: [
        Container(
          height: screenHeight,
          padding: EdgeInsets.only(left: 32.0, right: 32, top: 16),
          child: SingleChildScrollView(
            child: Column(children: [
              Container(
                //height: screenHeight * .7,
                //padding: EdgeInsets.only(left: 16, right: 16),
                decoration: BoxDecoration(
                  color: LoanTrackColors.PrimaryTwoLight.withOpacity(.05),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      padding: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: (due > 0)
                              ? LoanTrackColors.PrimaryOneLight
                              : LoanTrackColors2.PrimaryOne),
                      child: Text(
                        (due > 0) ? '${due} DAY(S) OVERDUE' : 'SAFE',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Loan Amount',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14)),
                            Text(widget.document!.get('loanAmount').toString(),
                                style: TextStyle(
                                    fontSize: 14,
                                    color: LoanTrackColors.PrimaryTwoVeryLight,
                                    fontWeight: FontWeight.bold))
                          ]),
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Amount Repaid',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14)),
                            Text(
                                widget.document!.get('amountRepaid').toString(),
                                style: TextStyle(
                                    fontSize: 14,
                                    color: LoanTrackColors.PrimaryTwoVeryLight,
                                    fontWeight: FontWeight.bold))
                          ]),
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Interest Rate',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14)),
                            Text(
                                widget.document!.get('interestRate').toString(),
                                style: TextStyle(
                                    fontSize: 14,
                                    color: LoanTrackColors.PrimaryTwoVeryLight,
                                    fontWeight: FontWeight.bold))
                          ]),
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Daily Overdue Charge',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14)),
                            Text(
                                widget.document!
                                    .get('dailyOverdueCharge')
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 14,
                                    color: LoanTrackColors.PrimaryTwoVeryLight,
                                    fontWeight: FontWeight.bold))
                          ]),
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Apply When',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14)),
                            Text(widget.document!.get('applyWhen').toString(),
                                style: TextStyle(
                                    fontSize: 14,
                                    color: LoanTrackColors.PrimaryTwoVeryLight,
                                    fontWeight: FontWeight.bold))
                          ]),
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Due When',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14)),
                            Text(widget.document!.get('dueWhen').toString(),
                                style: TextStyle(
                                    fontSize: 14,
                                    color: LoanTrackColors.PrimaryTwoVeryLight,
                                    fontWeight: FontWeight.bold))
                          ]),
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Last Repayment Date',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14)),
                            Text(
                                widget.document!.get('lastPaidWhen').toString(),
                                style: TextStyle(
                                    fontSize: 14,
                                    color: LoanTrackColors.PrimaryTwoVeryLight,
                                    fontWeight: FontWeight.bold))
                          ]),
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Lender Type',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14)),
                            Text(widget.document!.get('lenderType').toString(),
                                style: TextStyle(
                                    fontSize: 14,
                                    color: LoanTrackColors.PrimaryTwoVeryLight,
                                    fontWeight: FontWeight.bold))
                          ]),
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Lender',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14)),
                            Text(widget.document!.get('lender').toString(),
                                style: TextStyle(
                                    fontSize: 14,
                                    color: LoanTrackColors.PrimaryTwoVeryLight,
                                    fontWeight: FontWeight.bold))
                          ]),
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Loan Purpose',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14)),
                            Text(widget.document!.get('loanPurpose').toString(),
                                style: TextStyle(
                                    fontSize: 14,
                                    color: LoanTrackColors.PrimaryTwoVeryLight,
                                    fontWeight: FontWeight.bold))
                          ]),
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Note',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14)),
                            Container(
                                width: MediaQuery.of(context).size.width / 2.25,
                                child: Text(
                                    widget.document!.get('note').toString(),
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color:
                                            LoanTrackColors.PrimaryTwoVeryLight,
                                        fontWeight: FontWeight.bold)))
                          ]),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 100),
            ]),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewRepaymentRecord(
                                documentSnapshot: widget.document,
                              )));
                },
                child: Container(
                    width: screenWidth / 2,
                    child: LoanTrackButton.primary(
                        context: context, label: 'Add Repayment')),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/loanRecord');
                },
                child: Container(
                  width: screenWidth / 2,
                  child: LoanTrackButton.secondaryOutline(
                      context: context, label: 'Edit'),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
