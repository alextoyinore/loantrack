import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loantrack/apps/widgets/button.dart';
import 'package:loantrack/data/database.dart';
import 'package:loantrack/data/local.dart';
import 'package:loantrack/helpers/colors.dart';
import 'package:loantrack/helpers/icons.dart';
import 'package:loantrack/widgets/application_grid_view.dart';
import 'package:loantrack/widgets/dialogs.dart';
import 'package:loantrack/widgets/loan_track_modal.dart';
import 'package:loantrack/widgets/loan_track_textfield.dart';

class LoanRecord extends StatefulWidget {
  const LoanRecord({Key? key}) : super(key: key);

  @override
  State<LoanRecord> createState() => _LoanRecordState();
}

class _LoanRecordState extends State<LoanRecord> {
  final _userUID = FirebaseAuth.instance.currentUser!.uid;

  // Controllers
  TextEditingController loanAmountController = TextEditingController();
  TextEditingController repaidController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController loanPurposeController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  //Loan information controllers
  TextEditingController loanerTypeController = TextEditingController();
  TextEditingController loanerController = TextEditingController();

  // Date controllers
  TextEditingController applyWhenController = TextEditingController();
  TextEditingController dueWhenController = TextEditingController();
  TextEditingController lastPaidWhenController = TextEditingController();

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
            title: Text('New Loan Record'),
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

                  //Amount Field
                  LoanTrackTextField(
                    label: 'Loan Amount',
                    controller: loanAmountController,
                    color: LoanTrackColors.PrimaryOne,
                    icon: const Icon(Icons.receipt_long,
                        color: LoanTrackColors.PrimaryOne),
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                  ),
                  SizedBox(height: 20),

                  // Repaid Amount and Rate field
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Repaid amount
                      Container(
                        width: MediaQuery.of(context).size.width / 1.8,
                        child: LoanTrackTextField(
                          label: 'Repaid Amount',
                          controller: repaidController,
                          icon: Icon(Icons.receipt,
                              color: LoanTrackColors.PrimaryOne),
                          color: LoanTrackColors.PrimaryOne,
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                        ),
                      ),
                      SizedBox(width: 10),
                      // Rate
                      Container(
                        width: MediaQuery.of(context).size.width / 3,
                        child: LoanTrackTextField(
                          controller: rateController,
                          label: 'Rate',
                          color: LoanTrackColors.PrimaryOne,
                          icon: Icon(Icons.percent,
                              color: LoanTrackColors.PrimaryOne),
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),
                  Text('DATES'),
                  SizedBox(height: 20),

                  //Application Date and Due Date field
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Apply when
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2.25,
                            child: LoanTrackTextField(
                              controller: applyWhenController,
                              label: 'Apply When',
                              color: LoanTrackColors.PrimaryOne,
                              keyboardType: TextInputType.numberWithOptions(),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text('Format: YYYY-MM-DD',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: LoanTrackColors.PrimaryTwoVeryLight)),
                        ],
                      ),
                      SizedBox(width: 10),
                      // Due when
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2.25,
                            child: LoanTrackTextField(
                              controller: dueWhenController,
                              label: 'Due When',
                              color: LoanTrackColors.PrimaryOne,
                              keyboardType: TextInputType.numberWithOptions(),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text('Format: YYYY-MM-DD',
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
                        child: LoanTrackTextField(
                          controller: lastPaidWhenController,
                          label: 'Last Paid When',
                          color: LoanTrackColors.PrimaryOne,
                          keyboardType: TextInputType.numberWithOptions(),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text('Format: YYYY-MM-DD',
                          style: TextStyle(
                              fontSize: 12,
                              color: LoanTrackColors.PrimaryTwoVeryLight)),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text('LOANER INFORMATION'),
                  SizedBox(height: 20),

                  //LOaner information
                  Row(
                    children: [
                      //Loaner Type
                      Container(
                        width: MediaQuery.of(context).size.width / 2.25,
                        child: LoanTrackTextField(
                          controller: loanerTypeController,
                          label: 'Loaner Type',
                          color: LoanTrackColors.PrimaryOne,
                          //icon: Icon(Icons.note),
                        ),
                      ),
                      SizedBox(width: 10),
                      // Loaner
                      Container(
                        width: MediaQuery.of(context).size.width / 2.25,
                        child: LoanTrackTextField(
                          controller: loanerController,
                          label: 'Loaner',
                          color: LoanTrackColors.PrimaryOne,
                          //icon: Icon(Icons.note),
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
                    icon: const Icon(
                      Icons.note,
                      color: LoanTrackColors.PrimaryOne,
                    ),
                  ),

                  SizedBox(height: 100),
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
                GestureDetector(
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
                    } else if (loanerTypeController.text == '') {
                      error +=
                          'Loan Type cannot be empty. It\'s something like \'Online App\', \'Friend, Family or Other\', \'MFBs\'\n';
                    } else if (loanerController.text == '') {
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
                      db.updateLoanData(
                          loanAmount: loanAmountController.text,
                          amountRepaid: repaidController.text,
                          interestRate: rateController.text,
                          applyWhen: applyWhenController.text,
                          dueWhen: dueWhenController.text,
                          lastPaidWhen: lastPaidWhenController.text,
                          loanType: loanerTypeController.text,
                          loaner: loanerController.text,
                          loanPurpose: loanPurposeController.text,
                          note: noteController.text);
                      Navigator.pushNamed(context, '/home');
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: LoanTrackButton.primary(
                        context: context, label: 'Add Loan Record'),
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
