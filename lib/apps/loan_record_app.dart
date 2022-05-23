import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loantrack/apps/widgets/button.dart';
import 'package:loantrack/data/applists.dart';
import 'package:loantrack/data/database.dart';
import 'package:loantrack/helpers/colors.dart';
import 'package:loantrack/helpers/listwidgets.dart';
import 'package:loantrack/widgets/common_widgets.dart';
import 'package:loantrack/widgets/date_picker.dart';
import 'package:loantrack/widgets/dialogs.dart';
import 'package:loantrack/widgets/loan_progress_bar.dart';
import 'package:loantrack/widgets/loan_track_modal.dart';
import 'package:loantrack/widgets/loan_track_textfield.dart';

class LoanRecord extends StatefulWidget {
  LoanRecord({Key? key, this.documentSnapshot, required this.edit})
      : super(key: key);

  DocumentSnapshot? documentSnapshot;
  bool edit;

  @override
  State<LoanRecord> createState() => _LoanRecordState();
}

class _LoanRecordState extends State<LoanRecord> {
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

  // FOR REPAYMENT
  TextEditingController loanController = TextEditingController();
  TextEditingController amountRepaidController = TextEditingController();
  TextEditingController repaidWhenController = TextEditingController();
  TextEditingController balanceLeftController = TextEditingController();
  //TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Screen Sizes
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    // DUE and CURRENT AMOUNT
    int due = 0;
    double currentAmount = 0;

    if (widget.documentSnapshot != null && !widget.edit) {
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
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          /*      leading: GestureDetector(
              onTap: () {
                LoanTrackModal.modal(context,
                    content: const LoanTrackAppsGridView(),
                    height: screenHeight / 2.3,
                    title: 'Applications');
              },
              child: const Padding(
                padding: EdgeInsets.only(left: 24.0),
                child: LoanTrackIcons.ApplicationIcon,
              )),*/
          title: (widget.documentSnapshot != null && widget.edit == false)
              ? const Text(
                  'New Repayment Record',
                  style: TextStyle(color: LoanTrackColors.PrimaryOne),
                )
              : (widget.documentSnapshot != null && widget.edit == true)
                  ? const Text(
                      'Editing Record',
                      style: TextStyle(color: LoanTrackColors.PrimaryOne),
                    )
                  : const Text('New Loan Record',
                      style: TextStyle(color: LoanTrackColors.PrimaryOne)),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: Icon(
                  Icons.close,
                  color: LoanTrackColors.PrimaryTwo,
                ),
              ),
            )
          ],
        ),
        body: Stack(children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 24.0, top: 20, right: 24),
              child: (widget.documentSnapshot != null && !widget.edit)
                  ? RepaymentForm(context, screenHeight)
                  // BEGIN REPAYMENT VIEW
                  : (widget.documentSnapshot != null && widget.edit)
                      ?
                      // BEGIN EDIT VIEW
                      LoanEditForm(context)
                      // NEW LOAN RECORD
                      : NewLoanForm(context),
            ),
          ),
        ]),
      ),
    );
  }

  // NEW LOAN

  Column NewLoanForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Add a new loan record here by filling this form. All fields except \'Note\' are required.',
          style: TextStyle(
            color: LoanTrackColors.PrimaryTwoVeryLight,
          ),
        ),
        separatorSpace20,
        //The Money Section Title
        const Text(
          'THE MONEY',
          style: TextStyle(color: LoanTrackColors.PrimaryTwoLight),
        ),
        separatorSpace20,

        //Amount Field
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LoanTrackTextField(
              controller: loanAmountController,
              label: 'Loan Amount',
              color: LoanTrackColors.PrimaryOne,
              keyboardType: const TextInputType.numberWithOptions(),
            ),
            separatorSpace5,
            const Text('Total remitted + Service Charge',
                style: TextStyle(
                    fontSize: 12, color: LoanTrackColors.PrimaryTwoVeryLight)),
          ],
        ),
        separatorSpace20,

        // Repaid Amount and Rate field

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LoanTrackTextField(
              controller: repaidController,
              label: 'Amount Repaid',
              color: LoanTrackColors.PrimaryOne,
              keyboardType: const TextInputType.numberWithOptions(),
            ),
            separatorSpace5,
            const Text(
                'Total amount you have repaid to the loaner before creating this record. Enter Zero(0) if inapplicable',
                style: TextStyle(
                    fontSize: 12, color: LoanTrackColors.PrimaryTwoVeryLight)),
          ],
        ),
        separatorSpace20,
        // Rate
        LoanTrackTextField(
          controller: rateController,
          label: 'Initial Interest Rate',
          color: LoanTrackColors.PrimaryOne,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
        ),

        separatorSpace20,
        // Overdue Charge
        LoanTrackTextField(
          controller: overdueController,
          label: 'Daily Overdue Charge',
          color: LoanTrackColors.PrimaryOne,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
        ),

        // DATES

        separatorSpace20,
        const Text(
          'DATES',
          style: TextStyle(color: LoanTrackColors.PrimaryTwoLight),
        ),
        separatorSpace20,

        //Application Date and Due Date field
        Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Apply when
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LoanTrackDatePicker(
                  isPayment: false,
                  controller: applyWhenController,
                  initialText: 'Apply When',
                  yearsInFuture: 0,
                ),
                separatorSpace5,
                const Text('Format: YYYY-MM-DD',
                    style: TextStyle(
                        fontSize: 12,
                        color: LoanTrackColors.PrimaryTwoVeryLight)),
              ],
            ),
            separatorSpace20,
            // Due when
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LoanTrackDatePicker(
                  isPayment: false,
                  controller: dueWhenController,
                  initialText: 'Due When',
                  yearsInFuture: 10,
                ),
                separatorSpace5,
                const Text('Format: YYYY-MM-DD',
                    style: TextStyle(
                        fontSize: 12,
                        color: LoanTrackColors.PrimaryTwoVeryLight)),
              ],
            ),
          ],
        ),
        separatorSpace20,

        //Last payment date
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LoanTrackDatePicker(
              isPayment: false,
              controller: lastPaidWhenController,
              initialText: 'Last Paid When',
              yearsInFuture: 0,
            ),
            separatorSpace5,
            const Text(
                'Format: YYYY-MM-DD. * If no repayments have been made, kindly select the application date',
                style: TextStyle(
                    fontSize: 12, color: LoanTrackColors.PrimaryTwoVeryLight)),
          ],
        ),
        separatorSpace20,
        const Text(
          'LENDER INFORMATION',
          style: TextStyle(color: LoanTrackColors.PrimaryTwoLight),
        ),
        separatorSpace20,

        //Lender information
        Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Loaner Type
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => LoanTrackModal.modal(
                    context,
                    height: MediaQuery.of(context).size.height / 2.5,
                    content: Column(
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: List.generate(
                            AppLists.lenderType.length,
                            (index) => GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      lenderTypeController.text =
                                          AppLists.lenderType[index];
                                      Navigator.pop(context);
                                    });
                                  },
                                  child: ListTile(
                                    title: Text(
                                      AppLists.lenderType[index],
                                      style: const TextStyle(
                                        color:
                                            LoanTrackColors.PrimaryTwoVeryLight,
                                      ),
                                    ),
                                  ),
                                ))),
                    title: 'Lender Type',
                  ),
                  child: LoanTrackTextField(
                    enable: false,
                    controller: lenderTypeController,
                    label: 'Lender Type',
                    color: LoanTrackColors.PrimaryOne,
                    //icon: Icon(Icons.note),
                  ),
                ),
                separatorSpace5,
                const Text('Online App, Family & Friends, Bank & MFB',
                    style: TextStyle(
                        fontSize: 12,
                        color: LoanTrackColors.PrimaryTwoVeryLight)),
              ],
            ),
            separatorSpace20,
            // Lender
            Column(
              children: [
                LoanTrackTextField(
                  controller: lenderController,
                  label: 'Lender',
                  color: LoanTrackColors.PrimaryOne,
                  //icon: Icon(Icons.note),
                ),
                separatorSpace5,
                const Text(
                    'Enter Lender name or select one from the  list if available and applicable',
                    style: TextStyle(
                        fontSize: 12,
                        color: LoanTrackColors.PrimaryTwoVeryLight)),
              ],
            )
          ],
        ),

        // Loan purpose

        separatorSpace20,
        GestureDetector(
          onTap: () => LoanTrackModal.modal(
            context,
            height: MediaQuery.of(context).size.height / 2.5,
            content: Column(
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(
                    AppLists.loanPurpose.length,
                    (index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              loanPurposeController.text =
                                  AppLists.loanPurpose[index];
                              Navigator.pop(context);
                            });
                          },
                          child: ListTile(
                            title: Text(
                              AppLists.loanPurpose[index],
                              style: const TextStyle(
                                color: LoanTrackColors.PrimaryTwoVeryLight,
                              ),
                            ),
                          ),
                        ))),
            title: 'Loan Purpose',
          ),
          child: LoanTrackTextField(
            enable: false,
            controller: loanPurposeController,
            label: 'Loan Purpose',
            color: LoanTrackColors.PrimaryOne,
            //icon: Icon(Icons.note),
          ),
        ),

        separatorSpace20,
        const Text(
          'NOTE',
          style: TextStyle(
            color: LoanTrackColors.PrimaryTwoLight,
          ),
        ),
        separatorSpace20,

        // Loan Note
        LoanTrackTextField(
          label: 'Note',
          controller: noteController,
          color: LoanTrackColors.PrimaryOne,
        ),

        separatorSpace20,

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
                  context: context, title: 'Field Error', errorMessage: error);
            } else {
              DatabaseService db = DatabaseService();

              db
                  .updateLoanData(
                      loanAmount: double.parse(loanAmountController.text),
                      amountRepaid: double.parse(repaidController.text),
                      interestRate: double.parse(rateController.text),
                      dailyOverdueCharge: double.parse(overdueController.text),
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
                        'Loan record "${lenderController.text} - ${loanAmountController.text}" successfully created.',
                    whenTapped: () {
                      Navigator.pushNamed(context, '/home');
                    });
              }).onError((error, stackTrace) {
                showErrorDialog(
                    context: context,
                    title: 'Error',
                    errorMessage:
                        'An error has occurred while creating your loan record');
                if (kDebugMode) {
                  print(error);
                  print(stackTrace);
                }
              });
            }
          },
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: LoanTrackButton.primary(
                context: context, label: 'Add Loan Record'),
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }

  Column LoanEditForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Edit this loan record here by filling this form. All fields are optional. Only edit the fields you desire to update',
          style: TextStyle(
            color: LoanTrackColors.PrimaryTwoVeryLight,
          ),
        ),
        const SizedBox(height: 20),
        //The Money Section Title
        const Text(
          'THE MONEY',
          style: TextStyle(color: LoanTrackColors.PrimaryTwoVeryLight),
        ),
        const SizedBox(height: 20),

        //Amount Field
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LoanTrackTextField(
              controller: loanAmountController,
              label: 'Loan Amount',
              color: LoanTrackColors.PrimaryOne,
              keyboardType: const TextInputType.numberWithOptions(),
            ),
            const SizedBox(height: 5),
            const Text('Total remitted + Service Charge',
                style: TextStyle(
                    fontSize: 12, color: LoanTrackColors.PrimaryTwoVeryLight)),
          ],
        ),
        const SizedBox(height: 20),

        // Repaid Amount and Rate field

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LoanTrackTextField(
              controller: repaidController,
              label: 'Amount Repaid',
              color: LoanTrackColors.PrimaryOne,
              keyboardType: const TextInputType.numberWithOptions(),
            ),
            const SizedBox(height: 5),
            const Text(
                'Total amount you have repaid to the loaner before creating this record. Enter Zero(0) if inapplicable',
                style: TextStyle(
                    fontSize: 12, color: LoanTrackColors.PrimaryTwoVeryLight)),
          ],
        ),
        const SizedBox(height: 20),
        // Rate
        LoanTrackTextField(
          controller: rateController,
          label: 'Initial Interest Rate',
          color: LoanTrackColors.PrimaryOne,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
        ),

        const SizedBox(height: 20),
        // Rate
        LoanTrackTextField(
          controller: overdueController,
          label: 'Daily Overdue Charge',
          color: LoanTrackColors.PrimaryOne,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
        ),

        const SizedBox(height: 20),
        const Text(
          'DATES',
          style: TextStyle(color: LoanTrackColors.PrimaryTwoVeryLight),
        ),
        const SizedBox(height: 20),

        //Application Date and Due Date field
        Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Apply when
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LoanTrackDatePicker(
                  isPayment: false,
                  controller: applyWhenController,
                  initialText: 'Apply When',
                  yearsInFuture: 0,
                ),
                const SizedBox(height: 5),
                const Text('Format: YYYY-MM-DD',
                    style: TextStyle(
                        fontSize: 12,
                        color: LoanTrackColors.PrimaryTwoVeryLight)),
              ],
            ),
            const SizedBox(height: 20),
            // Due when
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LoanTrackDatePicker(
                  isPayment: false,
                  controller: dueWhenController,
                  initialText: 'Due When',
                  yearsInFuture: 10,
                ),
                const SizedBox(height: 5),
                const Text('Format: YYYY-MM-DD',
                    style: TextStyle(
                        fontSize: 12,
                        color: LoanTrackColors.PrimaryTwoVeryLight)),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),

        //Last payment date
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LoanTrackDatePicker(
              isPayment: false,
              controller: lastPaidWhenController,
              initialText: 'Last Paid When',
              yearsInFuture: 0,
            ),
            const SizedBox(height: 5),
            const Text('Format: YYYY-MM-DD',
                style: TextStyle(
                    fontSize: 12, color: LoanTrackColors.PrimaryTwoVeryLight)),
          ],
        ),
        const SizedBox(height: 20),
        const Text(
          'LOANER INFORMATION',
          style: TextStyle(color: LoanTrackColors.PrimaryTwoVeryLight),
        ),
        const SizedBox(height: 20),

        //LOaner information
        Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Loaner Type
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LoanTrackTextField(
                  controller: lenderTypeController,
                  label: 'Lender Type',
                  color: LoanTrackColors.PrimaryOne,
                  //icon: Icon(Icons.note),
                ),
                const SizedBox(height: 5),
                const Text('Online App, Family & Friends, Bank & MFB',
                    style: TextStyle(
                        fontSize: 12,
                        color: LoanTrackColors.PrimaryTwoVeryLight)),
              ],
            ),
            const SizedBox(height: 20),
            // Loaner
            Column(
              children: [
                LoanTrackTextField(
                  controller: lenderController,
                  label: 'Lender',
                  color: LoanTrackColors.PrimaryOne,
                  //icon: Icon(Icons.note),
                ),
                const SizedBox(height: 5),
                const Text(
                    'Enter Lender name or select one from the  list if available and applicable',
                    style: TextStyle(
                        fontSize: 12,
                        color: LoanTrackColors.PrimaryTwoVeryLight)),
              ],
            )
          ],
        ),

        // Loan purpose

        const SizedBox(height: 20),
        LoanTrackTextField(
          controller: loanPurposeController,
          label: 'Loan Purpose',
          color: LoanTrackColors.PrimaryOne,
          //icon: Icon(Icons.note),
        ),

        const SizedBox(height: 20),
        const Text('NOTE'),
        const SizedBox(height: 20),

        // Loan Note
        LoanTrackTextField(
          label: 'Note',
          controller: noteController,
          color: LoanTrackColors.PrimaryOne,
        ),

        const SizedBox(height: 20),

        GestureDetector(
          onTap: () {
            DatabaseService db = DatabaseService();

            db
                .updateSingleLoanData(
              entryDate: widget.documentSnapshot!.get('entryDate') ?? '',
              modifiedWhen: DateTime.now().toString().substring(0, 10),
              //LOAN ID EDIT FIELD
              id: widget.documentSnapshot!.id,
              // LOAN AMOUNT EDIT FIELD
              loanAmount: (loanAmountController.text.isNotEmpty)
                  ? double.parse(loanAmountController.text)
                  : widget.documentSnapshot!.get('loanAmount'),
              // REPAID AMOUNT EDIT FIELD
              amountRepaid: (repaidController.text.isNotEmpty)
                  ? double.parse(repaidController.text)
                  : widget.documentSnapshot!.get('amountRepaid'),
              //INTEREST RATE EDIT FIELD
              interestRate: (rateController.text.isNotEmpty)
                  ? double.parse(rateController.text)
                  : widget.documentSnapshot!.get('interestRate'),
              // DAILY OVERDUE CHARGE EDIT FIELD
              dailyOverdueCharge: (overdueController.text.isNotEmpty)
                  ? double.parse(overdueController.text)
                  : widget.documentSnapshot!.get('dailyOverdueCharge'),
              applyWhen: (applyWhenController.text.isNotEmpty)
                  ? applyWhenController.text
                  : widget.documentSnapshot!.get('applyWhen'),
              dueWhen: (dueWhenController.text.isNotEmpty)
                  ? dueWhenController.text
                  : widget.documentSnapshot!.get('dueWhen'),
              lastPaidWhen: (lastPaidWhenController.text.isNotEmpty)
                  ? lastPaidWhenController.text
                  : widget.documentSnapshot!.get('lastPaidWhen'),
              lenderType: (lenderTypeController.text.isNotEmpty)
                  ? lenderTypeController.text
                  : widget.documentSnapshot!.get('lenderType'),
              lender: (lenderController.text.isNotEmpty)
                  ? lenderController.text
                  : widget.documentSnapshot!.get('lender'),
              loanPurpose: (loanPurposeController.text.isNotEmpty)
                  ? loanPurposeController.text
                  : widget.documentSnapshot!.get('loanPurpose'),
              note: (noteController.text.isNotEmpty)
                  ? noteController.text
                  : widget.documentSnapshot!.get('note'),
            )
                .whenComplete(() {
              showSuccessDialog(
                  context: context,
                  title: 'Success',
                  successMessage:
                      'You have successfully edited record - ${widget.documentSnapshot!.get('lender')} loan',
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
          },
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: LoanTrackButton.primary(
                context: context, label: 'Edit Loan Record'),
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }

  Column RepaymentForm(BuildContext context, double screenHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Enter  a repayment record for ${widget.documentSnapshot!.get('loanAmount').toString()} loan owed to ${widget.documentSnapshot!.get('lender')} by filling this form. All fields are required.',
          style: const TextStyle(
            color: LoanTrackColors.PrimaryTwoVeryLight,
          ),
        ),
        const SizedBox(height: 20),
        //The Money Section Title
        const Text('THE MONEY'),
        const SizedBox(height: 20),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LoanTrackTextField(
              controller: loanController,
              label: 'The Loan',
              enable: false,
              color: LoanTrackColors.PrimaryOne,
              keyboardType: const TextInputType.numberWithOptions(),
            ),
            const SizedBox(height: 5),
            const Text('The loan you have to repay',
                style: TextStyle(
                    fontSize: 12, color: LoanTrackColors.PrimaryTwoVeryLight)),
          ],
        ),
        const SizedBox(height: 20),

        //Amount Repaid Field
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LoanTrackTextField(
              controller: amountRepaidController,
              label: 'Amount You Repaid',
              color: LoanTrackColors.PrimaryOne,
              keyboardType: const TextInputType.numberWithOptions(),
            ),
            const SizedBox(height: 5),
            const Text('The amount you paid against this loan',
                style: TextStyle(
                    fontSize: 12, color: LoanTrackColors.PrimaryTwoVeryLight)),
          ],
        ),
        const SizedBox(height: 20),

        //Application Date and Due Date field
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LoanTrackDatePicker(
              isPayment: true,
              controller: repaidWhenController,
              initialText: 'Payment Made When',
              yearsInFuture: 0,
            ),
            const SizedBox(height: 5),
            const Text('Format: YYYY-MM-DD',
                style: TextStyle(
                    fontSize: 12, color: LoanTrackColors.PrimaryTwoVeryLight)),
          ],
        ),

        const SizedBox(height: 20),

        //Last payment date
        LoanTrackTextField(
          controller: balanceLeftController,
          label: 'Balance Left',
          enable: false,
          color: LoanTrackColors.PrimaryOne,
          keyboardType: TextInputType.datetime,
        ),

        const SizedBox(height: 20),
        const Text('NOTE'),
        const SizedBox(height: 20),

        //Short Note
        LoanTrackTextField(
          controller: noteController,
          label: 'Note',
          color: LoanTrackColors.PrimaryOne,
        ),

        const SizedBox(height: 20),

        GestureDetector(
          onTap: () {
            String error = '';

            double loanAmount = widget.documentSnapshot!.get('loanAmount');
            double amountRepaid = widget.documentSnapshot!.get('amountRepaid');
            double dailyOverdueCharges =
                widget.documentSnapshot!.get('dailyOverdueCharge');
            String note = widget.documentSnapshot!.get('note');
            String id = widget.documentSnapshot!.id;

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
                  context: context, title: 'Field Error', errorMessage: error);
            } else {
              DatabaseService db = DatabaseService();
              db
                  .updateRepaymentData(
                      amountRepaid: double.parse(amountRepaidController.text),
                      note: noteController.text,
                      loanId: widget.documentSnapshot!.id,
                      repaidWhen: repaidWhenController.text)
                  .whenComplete(() {
                //UPDATING LOAN COLLECTION
                double remainder = loanAmount - amountRepaid;
                db.updateSingleLoanData(
                    entryDate: widget.documentSnapshot!.get('entryDate') ?? '',
                    modifiedWhen:
                        widget.documentSnapshot!.get('modifiedWhen') ?? '',
                    applyWhen: widget.documentSnapshot!.get('applyWhen'),
                    interestRate: widget.documentSnapshot!.get('interestRate'),
                    loanAmount: widget.documentSnapshot!.get('loanAmount'),
                    amountRepaid: amountRepaid +
                        double.parse(amountRepaidController.text),
                    dailyOverdueCharge: (remainder - amountRepaid <= 0)
                        ? 0
                        : dailyOverdueCharges,
                    lastPaidWhen: repaidWhenController.text,
                    note: note,
                    id: id,
                    dueWhen: widget.documentSnapshot!.get('dueWhen'),
                    loanPurpose: widget.documentSnapshot!.get('loanPurpose'),
                    lender: widget.documentSnapshot!.get(
                      'lender',
                    ),
                    lenderType: widget.documentSnapshot!.get(
                      'lenderType',
                    ));
                //END OF UPDATING COLLECTION
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
        const SizedBox(height: 30),

        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: LoanTrackColors.PrimaryOneVeryLight.withOpacity(.1),
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
              separatorSpace5,
              separatorLine,
              separatorSpace5,

              RepaymentBulletedList(
                  loanId: widget.documentSnapshot!.id,
                  height: screenHeight * .15,
                  userId: _userUID,
                  numberOfItems: 3)
            ],
          ),
        ),

        const SizedBox(height: 20),
        const Text('PROGRESS'),
        const SizedBox(height: 20),

        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: LoanProgressBar(
            snapshot: widget.documentSnapshot,
          ),
        ),

        const SizedBox(height: 30),
      ],
    );
  }
}
