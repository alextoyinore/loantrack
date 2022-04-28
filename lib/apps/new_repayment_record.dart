import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loantrack/apps/loan_tracking_page.dart';
import 'package:loantrack/apps/widgets/button.dart';
import 'package:loantrack/helpers/colors.dart';
import 'package:loantrack/helpers/icons.dart';
import 'package:loantrack/widgets/application_grid_view.dart';
import 'package:loantrack/widgets/bulleted_list.dart';
import 'package:loantrack/widgets/loan_track_modal.dart';
import 'package:loantrack/widgets/loan_track_textfield.dart';

import '../data/database.dart';
import '../widgets/date_picker.dart';
import '../widgets/dialogs.dart';
import '../widgets/loan_progress_bar.dart';

class NewRepaymentRecord extends StatefulWidget {
  NewRepaymentRecord({Key? key, this.documentSnapshot}) : super(key: key);

  DocumentSnapshot? documentSnapshot;

  @override
  State<NewRepaymentRecord> createState() => _NewRepaymentRecordState();
}

class _NewRepaymentRecordState extends State<NewRepaymentRecord> {
  TextEditingController loanController = TextEditingController();
  TextEditingController amountRepaidController = TextEditingController();
  TextEditingController dateOfPayment = TextEditingController();
  TextEditingController balanceLeftController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Screen Sizes
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    // DUE and CURRENT AMOUNT
    int due = 0;
    double currentAmount = 0;

    if (widget.documentSnapshot != null) {
      // DUE
      DateTime dueWhen =
          DateTime.parse(widget.documentSnapshot!.get('dueWhen').toString());
      Duration duration = DateTime.now().difference(dueWhen);
      due = duration.inDays;
      //END DUE

      setState(() {
        currentAmount = (widget.documentSnapshot!.get('loanAmount') -
                widget.documentSnapshot!.get('amountRepaid')) +
            (widget.documentSnapshot!.get('dailyOverdueCharge') * due);
        loanController.text = (widget.documentSnapshot != null)
            ? 'Loan - ${widget.documentSnapshot!.get('lender')} ${(currentAmount).toString()}'
            : '';
        (amountRepaidController.text != '')
            ? balanceLeftController.text =
                (currentAmount - double.parse(amountRepaidController.text))
                    .toString()
            : '';
      });
    }

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white, //Colors.black12.withOpacity(0.03),
            elevation: 0,
            foregroundColor: LoanTrackColors.PrimaryOne,
            leading: Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: GestureDetector(
                  onTap: () {
                    LoanTrackModal.modal(context,
                        content: const LoanTrackAppsGridView(),
                        title: 'Applications');
                  },
                  child: LoanTrackIcons.ApplicationIcon),
            ),
            title: const Text('New Repayment Record'),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 32.0),
                child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.close)),
              )
            ]),
        body: (widget.documentSnapshot != null)
            ? Stack(children: [
                SingleChildScrollView(
                    child: Padding(
                  padding:
                      const EdgeInsets.only(left: 32.0, top: 20, right: 32),
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

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            //width: MediaQuery.of(context).size.width / 2.25,
                            child: LoanTrackTextField(
                              controller: loanController,
                              label: 'The Loan',
                              enable: false,
                              color: LoanTrackColors.PrimaryOne,
                              keyboardType: TextInputType.numberWithOptions(),
                            ),
                          ),
                          SizedBox(height: 5),
                          const Text('The loan you have to repaid',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: LoanTrackColors.PrimaryTwoVeryLight)),
                        ],
                      ),
                      SizedBox(height: 20),

                      //Amount Repaid Field
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            //width: MediaQuery.of(context).size.width / 2.25,
                            child: LoanTrackTextField(
                              controller: amountRepaidController,
                              label: 'Amount You Repaid',
                              color: LoanTrackColors.PrimaryOne,
                              keyboardType: TextInputType.numberWithOptions(),
                            ),
                          ),
                          SizedBox(height: 5),
                          const Text('The amount you paid against this loan',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: LoanTrackColors.PrimaryTwoVeryLight)),
                        ],
                      ),
                      SizedBox(height: 20),

                      //Application Date and Due Date field
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            //width: MediaQuery.of(context).size.width / 2.25,
                            child: LoanTrackDatePicker(
                              isPayment: false,
                              controller: dateOfPayment,
                              initialText: 'Payment Made When',
                              yearsInFuture: 0,
                            ),
                          ),
                          SizedBox(height: 5),
                          const Text('Format: YYYY-MM-DD',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: LoanTrackColors.PrimaryTwoVeryLight)),
                        ],
                      ),

                      SizedBox(height: 20),

                      //Last payment date
                      Container(
                        // width: MediaQuery.of(context).size.width / 2.3,
                        child: LoanTrackTextField(
                          controller: balanceLeftController,
                          label: 'Balance Left',
                          enable: false,
                          color: LoanTrackColors.PrimaryOne,
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
                          controller: noteController,
                          label: 'Note',
                          color: LoanTrackColors.PrimaryOne,
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
                              style:
                                  TextStyle(color: LoanTrackColors.PrimaryOne),
                            ),
                            //SizedBox(height: 20),

                            SizedBox(height: 10),
                            BulletedList(
                                text: 'LCREDIT - 3000 - 2022-03-02, Noon',
                                style: TextStyle(
                                    color: LoanTrackColors.PrimaryOne)),
                            SizedBox(height: 5),
                            BulletedList(
                                text: 'CASHBUS - 4000 - 2022-03-05, Night',
                                style: TextStyle(
                                    color: LoanTrackColors.PrimaryOne)),
                            SizedBox(height: 5),
                            BulletedList(
                                text: '9CREDIT - 3500 - 2022-04-07, Morning',
                                style: TextStyle(
                                    color: LoanTrackColors.PrimaryOne))
                          ],
                        ),
                      ),

                      SizedBox(height: 20),
                      Text('PROGRESS'),
                      SizedBox(height: 20),

                      LoanProgressBar(
                        snapshot: widget.documentSnapshot,
                      ),

                      SizedBox(height: 100),
                    ],
                  ),
                )),
                Positioned(
                  bottom: 0,
                  child: GestureDetector(
                    onTap: () {
                      String error = '';

                      if (amountRepaidController.text == '' ||
                          amountRepaidController.text == '0') {
                        error += 'Amount Repaid cannot be empty or zero (0)\n';
                      } else if (amountRepaidController.text == '') {
                        error +=
                            'Repaid Amount field cannot be empty. If no repayments have been made, enter zero (0)\n';
                      } else if (noteController.text == '') {
                        error +=
                            'Note field cannot be empty. Remembering the fine details of the loan can save you should things go south.\n';
                      }

                      if (error.isNotEmpty) {
                        showErrorDialog(
                            context: context,
                            title: 'Field Error',
                            errorMessage: error);
                      } else {
                        DatabaseService db = DatabaseService();
                        db
                            .updateRepaymentData(
                                amountRepaid:
                                    double.parse(amountRepaidController.text),
                                note: noteController.text,
                                loanId: widget.documentSnapshot!.id,
                                dateOfRepayment: dateOfPayment.text)
                            .whenComplete(() {
                          showSuccessDialog(
                              context: context,
                              title: 'Success',
                              successMessage:
                                  'You have successfully added a repayment record to your ${widget.documentSnapshot!.get('lender')} loan',
                              whenTapped: () {
                                Navigator.pushNamed(context, '/home');
                              });
                        }).onError((error, stackTrace) {
                          showErrorDialog(
                              context: context,
                              title: 'Error',
                              errorMessage:
                                  'An error has occurred while creating your repayment record');
                        });
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: LoanTrackButton.primary(
                          context: context, label: 'Add Loan Record'),
                    ),
                  ),
                )
              ])
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 32.0, right: 32.0),
                    child: Text(
                      'Select one loan record to repay. You may sort by \'Date\', \'Lender\', \'Amount\' or \'Repaid\'',
                      style:
                          TextStyle(color: LoanTrackColors.PrimaryTwoVeryLight),
                    ),
                  ),
                  LoanTrackingPage(
                      isHome: false, loanListHeight: screenHeight / 1.7),
                ],
              ),
      ),
    );
    //: LoanHistoryApp();
  }
}
