import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loantrack/apps/widgets/button.dart';
import 'package:loantrack/data/database.dart';
import 'package:loantrack/helpers/colors.dart';
import 'package:loantrack/helpers/icons.dart';
import 'package:loantrack/widgets/application_grid_view.dart';
import 'package:loantrack/widgets/date_picker.dart';
import 'package:loantrack/widgets/dialogs.dart';
import 'package:loantrack/widgets/loan_track_modal.dart';
import 'package:loantrack/widgets/loan_track_textfield.dart';

class NewLoanRecord extends StatefulWidget {
  NewLoanRecord({Key? key, this.document}) : super(key: key);

  DocumentSnapshot? document;

  @override
  State<NewLoanRecord> createState() => _NewLoanRecordState();
}

class _NewLoanRecordState extends State<NewLoanRecord> {
  final _userUID = FirebaseAuth.instance.currentUser!.uid;

  // Controllers
  TextEditingController loanAmountController = TextEditingController();
  TextEditingController repaidController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController overdueController = TextEditingController();

  // Extras
  TextEditingController loanPurposeController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  //Loan information controllers
  TextEditingController lenderTypeController = TextEditingController();
  TextEditingController lenderController = TextEditingController();

  // Date controllers
  TextEditingController applyWhenController = TextEditingController();
  TextEditingController dueWhenController = TextEditingController();
  TextEditingController lastPaidWhenController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
            title: Text('New Loan Record'),
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
        body: Stack(children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 32.0, top: 20, right: 32),
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

                  //Amount Field
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        //width: MediaQuery.of(context).size.width / 2.25,
                        child: LoanTrackTextField(
                          controller: loanAmountController,
                          label: 'Loan Amount',
                          color: LoanTrackColors.PrimaryOne,
                          keyboardType: TextInputType.numberWithOptions(),
                        ),
                      ),
                      SizedBox(height: 5),
                      const Text('Total remitted + Service Charge',
                          style: TextStyle(
                              fontSize: 12,
                              color: LoanTrackColors.PrimaryTwoVeryLight)),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Repaid Amount and Rate field

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        //width: MediaQuery.of(context).size.width / 2.25,
                        child: LoanTrackTextField(
                          controller: repaidController,
                          label: 'Amount Repaid',
                          color: LoanTrackColors.PrimaryOne,
                          keyboardType: TextInputType.numberWithOptions(),
                        ),
                      ),
                      SizedBox(height: 5),
                      const Text(
                          'Total amount you have repaid to the loaner before creating this record. Enter Zero(0) if inapplicable',
                          style: TextStyle(
                              fontSize: 12,
                              color: LoanTrackColors.PrimaryTwoVeryLight)),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Rate
                  Container(
                    //width: MediaQuery.of(context).size.width / 3,
                    child: LoanTrackTextField(
                      controller: rateController,
                      label: 'Initial Interest Rate',
                      color: LoanTrackColors.PrimaryOne,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                    ),
                  ),

                  SizedBox(height: 20),
                  // Rate
                  Container(
                    //width: MediaQuery.of(context).size.width / 3,
                    child: LoanTrackTextField(
                      controller: overdueController,
                      label: 'Daily Overdue Charge',
                      color: LoanTrackColors.PrimaryOne,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                    ),
                  ),

                  SizedBox(height: 20),
                  Text('DATES'),
                  SizedBox(height: 20),

                  //Application Date and Due Date field
                  Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Apply when
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            //width: MediaQuery.of(context).size.width / 2.25,
                            child: LoanTrackDatePicker(
                              isPayment: false,
                              controller: applyWhenController,
                              initialText: 'Apply When',
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
                      // Due when
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            //width: MediaQuery.of(context).size.width / 2.25,
                            child: LoanTrackDatePicker(
                              isPayment: false,
                              controller: dueWhenController,
                              initialText: 'Due When',
                              yearsInFuture: 10,
                            ),
                          ),
                          SizedBox(height: 5),
                          const Text('Format: YYYY-MM-DD',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: LoanTrackColors.PrimaryTwoVeryLight)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  //Last payment date
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        //width: MediaQuery.of(context).size.width / 2.25,
                        child: LoanTrackDatePicker(
                          isPayment: false,
                          controller: lastPaidWhenController,
                          initialText: 'Last Paid When',
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
                  Text('LOANER INFORMATION'),
                  SizedBox(height: 20),

                  //LOaner information
                  Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Loaner Type
                      Container(
                        //width: MediaQuery.of(context).size.width / 2.25,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: LoanTrackTextField(
                                controller: lenderTypeController,
                                label: 'Lender Type',
                                color: LoanTrackColors.PrimaryOne,
                                //icon: Icon(Icons.note),
                              ),
                            ),
                            SizedBox(height: 5),
                            const Text(
                                'Online App, Family & Friends, Bank & MFB',
                                style: TextStyle(
                                    fontSize: 12,
                                    color:
                                        LoanTrackColors.PrimaryTwoVeryLight)),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      // Loaner
                      Container(
                        //width: MediaQuery.of(context).size.width / 2.25,
                        child: Column(
                          children: [
                            Container(
                              child: LoanTrackTextField(
                                controller: lenderController,
                                label: 'Lender',
                                color: LoanTrackColors.PrimaryOne,
                                //icon: Icon(Icons.note),
                              ),
                            ),
                            SizedBox(height: 5),
                            const Text(
                                'Enter Lender name or select one from the  list if available and applicable',
                                style: TextStyle(
                                    fontSize: 12,
                                    color:
                                        LoanTrackColors.PrimaryTwoVeryLight)),
                          ],
                        ),
                      )
                    ],
                  ),

                  // Loan purpose

                  SizedBox(height: 20),
                  LoanTrackTextField(
                    controller: loanPurposeController,
                    label: 'Loan Purpose',
                    color: LoanTrackColors.PrimaryOne,
                    //icon: Icon(Icons.note),
                  ),

                  SizedBox(height: 20),
                  Text('NOTE'),
                  SizedBox(height: 20),

                  // Loan Note
                  LoanTrackTextField(
                    label: 'Note',
                    controller: noteController,
                    color: LoanTrackColors.PrimaryOne,
                  ),

                  SizedBox(height: 100),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: GestureDetector(
              onTap: () {
                String error = '';

                if (loanAmountController.text == '' ||
                    loanAmountController.text == '0') {
                  error += 'Loan Amount cannot be empty or zero (0)\n';
                } else if (repaidController.text == '') {
                  error +=
                      'Repaid Amount field cannot be empty. If no repayments have been made, enter zero (0)\n';
                } else if (rateController.text == '') {
                  error +=
                      'Rate Amount field cannot be empty. If no Interests are required, enter zero (0)';
                } else if (applyWhenController.text == '' ||
                    !applyWhenController.text.contains('-') ||
                    applyWhenController.text.length < 10) {
                  error +=
                      'Apply When field cannot be empty. Also, check that the format is of YYYY-MM-DD e.g 2022-04-05.\n';
                } else if (dueWhenController.text == '' ||
                    !dueWhenController.text.contains('-') ||
                    dueWhenController.text.length < 10) {
                  error +=
                      'Due When field cannot be empty. Also, check that the format is of YYYY-MM-DD e.g 2022-04-05.\n';
                } else if (lastPaidWhenController.text == '' ||
                    !lastPaidWhenController.text.contains('-') ||
                    lastPaidWhenController.text.length < 10) {
                  error +=
                      'Last Paid When field cannot be empty. Also, check that the format is of YYYY-MM-DD e.g 2022-04-05.\n\nEnter Zero(0) if no payments have been made.\n';
                } else if (lenderTypeController.text == '') {
                  error +=
                      'Loan Type cannot be empty. It\'s something like \'Online App\', \'Friend, Family or Other\', \'MFBs\'\n';
                } else if (lenderController.text == '') {
                  error +=
                      'Loaner cannot be empty. You need to know who you took the loan from or loaned your money out to.\n';
                } else if (loanPurposeController.text == '') {
                  error +=
                      'Knowing why you took the loan in the first place may help keep things in perspective. Purpose field cannot be empty. E.g. \'Education\', \'Medical\', \'Business\', or \'Offset Loan\'.\n';
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
                      .updateLoanData(
                          loanAmount: double.parse(loanAmountController.text),
                          amountRepaid: double.parse(repaidController.text),
                          interestRate: double.parse(rateController.text),
                          dailyOverdueCharge:
                              double.parse(overdueController.text),
                          applyWhen: applyWhenController.text,
                          dueWhen: dueWhenController.text,
                          lastPaidWhen: lastPaidWhenController.text,
                          lenderType: lenderTypeController.text,
                          lender: lenderController.text,
                          loanPurpose: loanPurposeController.text,
                          note: noteController.text)
                      .whenComplete(() {
                    showSuccessDialog(
                        context: context,
                        title: 'Success',
                        successMessage:
                            'You have successfully added a repayment record to your ${widget.document!.get('lender')} loan',
                        whenTapped: () {
                          Navigator.pushNamed(context, '/home');
                        });
                  }).onError((error, stackTrace) {
                    showErrorDialog(
                        context: context,
                        title: 'Error',
                        errorMessage:
                            'An error has occurred while creating your loan record');
                  });
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: LoanTrackButton.primary(
                    context: context, label: 'Add Loan Record'),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
