import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loantrack/apps/loan_record.dart';
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
                  //color: LoanTrackColors.PrimaryTwoLight.withOpacity(.05),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: screenHeight / 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.archive_outlined,
                          color: LoanTrackColors2.PrimaryOne,
                        ),
                        Text(
                          '${widget.document!.get('lender').toString().toUpperCase()} - ${((widget.document!.get('loanAmount') - widget.document!.get('amountRepaid')) + (widget.document!.get('dailyOverdueCharge') * due)).toString()}',
                          style:
                              TextStyle(color: LoanTrackColors.PrimaryTwoLight),
                        ),
                        GestureDetector(
                          onTap: () {
                            FirebaseFirestore.instance
                                .collection('loans')
                                .doc(widget.document!.id)
                                .delete();
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.delete_outline,
                            color: LoanTrackColors2.PrimaryOneLight,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        //borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: (due > 0)
                                ? LoanTrackColors2.PrimaryOneLight
                                : LoanTrackColors.PrimaryOne),
                      ),
                      child: Text(
                        (due > 0) ? '${due} DAY(S) OVERDUE' : 'SAFE',
                        style: TextStyle(
                            color: (due > 0)
                                ? LoanTrackColors2.PrimaryOneLight
                                : LoanTrackColors.PrimaryOne),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    SizedBox(height: 20),

                    //Loan Amount
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Loan Amount',
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 14,
                                color: LoanTrackColors.PrimaryTwoLight)),
                        Text(widget.document!.get('loanAmount').toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                              color: LoanTrackColors.PrimaryTwoLight,
                            ))
                      ],
                    ),

                    Divider(
                        thickness: .5, color: LoanTrackColors.PrimaryTwoLight),

                    // Amount Repaid
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Amount Repaid',
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 14,
                                color: LoanTrackColors.PrimaryTwoLight)),
                        Text(widget.document!.get('amountRepaid').toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                              color: LoanTrackColors.PrimaryTwoLight,
                            ))
                      ],
                    ),
                    Divider(
                        thickness: .5, color: LoanTrackColors.PrimaryTwoLight),

                    // Interest Rate
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Interest Rate',
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 14,
                                color: LoanTrackColors.PrimaryTwoLight)),
                        Text(widget.document!.get('interestRate').toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                              color: LoanTrackColors.PrimaryTwoLight,
                            ))
                      ],
                    ),
                    Divider(
                        thickness: .5, color: LoanTrackColors.PrimaryTwoLight),

                    // Daily Overdue Charge
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Daily Overdue Charge',
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 14,
                                color: LoanTrackColors.PrimaryTwoLight)),
                        Text(
                            widget.document!
                                .get('dailyOverdueCharge')
                                .toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                              color: LoanTrackColors.PrimaryTwoLight,
                            ))
                      ],
                    ),
                    Divider(
                        thickness: .5, color: LoanTrackColors.PrimaryTwoLight),

                    //Apply When
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Apply When',
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 14,
                                color: LoanTrackColors.PrimaryTwoLight)),
                        Text(widget.document!.get('applyWhen').toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                              color: LoanTrackColors.PrimaryTwoLight,
                            ))
                      ],
                    ),

                    Divider(
                        thickness: .5, color: LoanTrackColors.PrimaryTwoLight),

                    // Due When

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Due When',
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 14,
                                color: LoanTrackColors.PrimaryTwoLight)),
                        Text(widget.document!.get('dueWhen').toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                              color: LoanTrackColors.PrimaryTwoLight,
                            ))
                      ],
                    ),
                    Divider(
                        thickness: .5, color: LoanTrackColors.PrimaryTwoLight),

                    // Last Repayment Date
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Last Repayment Date',
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 14,
                                color: LoanTrackColors.PrimaryTwoLight)),
                        Text(widget.document!.get('lastPaidWhen').toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                              color: LoanTrackColors.PrimaryTwoLight,
                            ))
                      ],
                    ),

                    Divider(
                        thickness: .5, color: LoanTrackColors.PrimaryTwoLight),

                    // Lender Type
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Lender Type',
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 14,
                                color: LoanTrackColors.PrimaryTwoLight)),
                        Text(widget.document!.get('lenderType').toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                              color: LoanTrackColors.PrimaryTwoLight,
                            ))
                      ],
                    ),

                    Divider(
                        thickness: .5, color: LoanTrackColors.PrimaryTwoLight),

                    // Lender
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Lender',
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 14,
                                color: LoanTrackColors.PrimaryTwoLight)),
                        Text(widget.document!.get('lender').toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                              color: LoanTrackColors.PrimaryTwoLight,
                            ))
                      ],
                    ),
                    Divider(
                        thickness: .5, color: LoanTrackColors.PrimaryTwoLight),

                    // Loan Purpose
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Loan Purpose',
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 14,
                                color: LoanTrackColors.PrimaryTwoLight)),
                        Text(widget.document!.get('loanPurpose').toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                              color: LoanTrackColors.PrimaryTwoLight,
                            ))
                      ],
                    ),
                    Divider(
                        thickness: .5, color: LoanTrackColors.PrimaryTwoLight),

                    //Note
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Note',
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 14,
                                color: LoanTrackColors.PrimaryTwoLight)),
                        Container(
                            width: MediaQuery.of(context).size.width / 2.25,
                            child: Text(widget.document!.get('note').toString(),
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14,
                                  color: LoanTrackColors.PrimaryTwoLight,
                                )))
                      ],
                    ),
                    SizedBox(height: 50),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewLoanRecord(
                                      documentSnapshot: widget.document,
                                    )));
                      },
                      child: Container(
                          //width: screenWidth,
                          child: LoanTrackButton.primary(
                              context: context, label: 'Repay')),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewLoanRecord(
                                      documentSnapshot: widget.document,
                                      edit: true,
                                    )));
                      },
                      child: Container(
                          //width: screenWidth,
                          child: LoanTrackButton.secondary(
                              context: context, label: 'Edit')),
                    ),
                    /* Row(
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
                              //width: screenWidth,
                              child: LoanTrackButton.secondaryOutline(
                                  context: context, label: 'Add Repayment')),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/loanRecord');
                          },
                          child: Container(
                            width: screenWidth / 2.5,
                            child: LoanTrackButton.secondaryOutline(
                                context: context, label: 'Edit'),
                          ),
                        )
                      ],
                    ),*/
                  ],
                ),
              ),
              SizedBox(height: 100),
            ]),
          ),
        ),
      ]),
    );
  }
}
