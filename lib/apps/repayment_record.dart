import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loantrack/apps/widgets/button.dart';
import 'package:loantrack/data/local.dart';
import 'package:loantrack/helpers/colors.dart';
import 'package:loantrack/helpers/icons.dart';
import 'package:loantrack/widgets/application_grid_view.dart';
import 'package:loantrack/widgets/bulleted_list.dart';
import 'package:loantrack/widgets/loan_track_dropdownfield.dart';
import 'package:loantrack/widgets/loan_track_modal.dart';
import 'package:loantrack/widgets/loan_track_textfield.dart';

class RepaymentRecord extends StatefulWidget {
  const RepaymentRecord({Key? key}) : super(key: key);

  @override
  State<RepaymentRecord> createState() => _RepaymentRecordState();
}

class _RepaymentRecordState extends State<RepaymentRecord> {
  String loanDropdownValue = '';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white, //Colors.black12.withOpacity(0.03),
            elevation: 0,
            foregroundColor: LoanTrackColors.PrimaryOne,
            leading: GestureDetector(
                onTap: () {
                  LoanTrackModal.modal(context,
                      content: const LoanTrackAppsGridView(),
                      title: 'Applications');
                },
                child: LoanTrackIcons.ApplicationIcon),
            title: const Text('New Repayment Record'),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: GestureDetector(
                    onTap: () {
                      LoanTrackModal.modal(context,
                          content: const SingleChildScrollView(
                              child: Text(LocalData.aboutLoanTrack,
                                  style: TextStyle(
                                      fontSize: 16,
                                      height: 1.5,
                                      color: LoanTrackColors.PrimaryOne),
                                  softWrap: true)),
                          title: 'About');
                    },
                    child: Icon(Icons.menu)),
              )
            ]),
        body: Stack(children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 20, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Add a new loan record here by filling this form. All fields except \'Note\' are required.',
                    style: TextStyle(
                      color: LoanTrackColors.PrimaryTwoVeryLight,
                    ),
                  ),
                  SizedBox(height: 20),
                  //The Money Section Title
                  Text('THE MONEY'),
                  SizedBox(height: 20),

                  Container(
                    //width: MediaQuery.of(context).size.width / 2.25,
                    child: LoanTrackDropDownField(
                      dropdownValue: loanDropdownValue,
                      label: 'Which Loan',
                      list: const [
                        'LCredit - 23,000',
                        '9Credit - 8,000',
                        'CashCredit - 6,000',
                        'SplashNaira - 8500',
                      ],
                      color: LoanTrackColors.PrimaryOne,
                    ),
                  ),

                  SizedBox(height: 20),

                  //Amount Field
                  LoanTrackTextField(
                    label: 'Amount Paid',
                    color: LoanTrackColors.PrimaryOne,
                    icon: Icon(Icons.receipt_long,
                        color: LoanTrackColors.PrimaryOne),
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                  ),
                  SizedBox(height: 20),
                  //Application Date and Due Date field
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2.25,
                        child: LoanTrackTextField(
                          label: 'Payment Date',
                          icon: Icon(Icons.calendar_today_outlined,
                              color: LoanTrackColors.PrimaryOne),
                          color: LoanTrackColors.PrimaryOne,
                          keyboardType: TextInputType.datetime,
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        width: MediaQuery.of(context).size.width / 2.25,
                        child: LoanTrackTextField(
                          label: 'Time',
                          color: LoanTrackColors.PrimaryOne,
                          icon: Icon(Icons.access_time,
                              color: LoanTrackColors.PrimaryOne),
                          keyboardType: TextInputType.datetime,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  //Last payment date
                  Container(
                    // width: MediaQuery.of(context).size.width / 2.3,
                    child: LoanTrackTextField(
                      label: 'Balance Left',
                      enable: false,
                      color: LoanTrackColors.PrimaryOne,
                      icon:
                          Icon(Icons.money, color: LoanTrackColors.PrimaryOne),
                      keyboardType: TextInputType.datetime,
                    ),
                  ),

                  SizedBox(height: 20),
                  Text('NOTE'),
                  SizedBox(height: 20),

                  //Short Note
                  Container(
                    // width: MediaQuery.of(context).size.width / 2.3,
                    child: LoanTrackTextField(
                      label: 'Note',
                      color: LoanTrackColors.PrimaryOne,
                      icon:
                          Icon(Icons.money, color: LoanTrackColors.PrimaryOne),
                    ),
                  ),

                  SizedBox(height: 20),

                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: LoanTrackColors.PrimaryOne.withOpacity(.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //SizedBox(height: 20),
                        const Text(
                          'YOUR RECENT REPAYMENTS',
                          style: TextStyle(color: LoanTrackColors.PrimaryOne),
                        ),
                        //SizedBox(height: 20),
                        /*LoanProgressBar(
                            loan: Loan(
                          amountRepaid: 15000,
                          interestRate: .1,
                          loaner: Loaner(
                            name: 'LCredit',
                          ),
                          loanAmount: 25000,
                        )),*/
                        SizedBox(height: 10),
                        BulletedList(
                            text: 'LCREDIT - 3000 - 2022-03-02, Noon',
                            style:
                                TextStyle(color: LoanTrackColors.PrimaryOne)),
                        SizedBox(height: 5),
                        BulletedList(
                            text: 'CASHBUS - 4000 - 2022-03-05, Night',
                            style:
                                TextStyle(color: LoanTrackColors.PrimaryOne)),
                        SizedBox(height: 5),
                        BulletedList(
                            text: '9CREDIT - 3500 - 2022-04-07, Morning',
                            style: TextStyle(color: LoanTrackColors.PrimaryOne))
                      ],
                    ),
                  ),

                  SizedBox(height: 200),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: LoanTrackButton.secondaryOutline(
                        context: context, label: 'Cancel'),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: LoanTrackButton.primary(
                      context: context, label: 'Add Payment Record'),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
