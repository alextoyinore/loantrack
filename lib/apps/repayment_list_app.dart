import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loantrack/helpers/colors.dart';
import 'package:loantrack/helpers/common_widgets.dart';
import 'package:loantrack/helpers/functions.dart';
import 'package:loantrack/widgets/loan_track_modal.dart';

class RepaymentHistory extends StatefulWidget {
  const RepaymentHistory({Key? key}) : super(key: key);

  @override
  State<RepaymentHistory> createState() => _RepaymentHistoryState();
}

class _RepaymentHistoryState extends State<RepaymentHistory> {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          separatorSpace50,
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child:
                      Icon(Icons.arrow_back, color: LoanTrackColors.PrimaryOne),
                ),
                const Text('Repayment History',
                    style: TextStyle(
                        color: LoanTrackColors.PrimaryOne, fontSize: 20)),
                GestureDetector(
                  onTap: () => LoanTrackModal.modal(context,
                      content: const Text(
                          'In this app you can track all your loan repayments at a glance'),
                      title: 'About Repayment App'),
                  child: const Icon(
                    Icons.info,
                    color: LoanTrackColors.PrimaryTwoVeryLight,
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24.0),
            child: RepaymentBulletedList(
                height: MediaQuery.of(context).size.height * .7,
                userId: userId),
          ),
        ],
      ),
    ));
  }
}
