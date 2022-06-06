import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loantrack/apps/providers/loan_provider.dart';
import 'package:provider/provider.dart';

import '../helpers/styles.dart';
import '../widgets/common_widgets.dart';

class Summary extends StatefulWidget {
  const Summary({Key? key}) : super(key: key);

  @override
  State<Summary> createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  String userId = FirebaseAuth.instance.currentUser!.uid;

  int numberOfLenders = 0;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 260,
                ),
                Container(
                  height: screenHeight / 2,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      separatorSpace10,
                      // Total repaid Box
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'TOTAL REPAID',
                            style: bodyStyle(context),
                          ),
                          separatorSpace10,
                          Text(
                            context
                                .read<LoanDetailsProviders>()
                                .repaidTotal
                                .toString(),
                            style: smallTitleStyle(context),
                          ),
                          separatorSpace40,
                          Text('CURRENT LOAN TOTAL', style: bodyStyle(context)),
                          separatorSpace10,
                          Text(
                            context
                                .read<LoanDetailsProviders>()
                                .loanTotal
                                .toString(),
                            style: smallTitleStyle(context),
                          ),
                          separatorSpace40,
                          Text(
                            'TOTAL NUMBER Of LENDERS',
                            style: bodyStyle(context),
                          ),
                          separatorSpace10,
                          Text(
                            context
                                .read<LoanDetailsProviders>()
                                .numberOfLenders
                                .toString(),
                            style: smallTitleStyle(context),
                          ),
                        ],
                      ),

                      separatorSpace40,

                      //Total Loan owed Box
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Theme.of(context).colorScheme.background,
            height: MediaQuery.of(context).size.height / 3.2,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  separatorSpace40,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.close)),
                    ],
                  ),
                  separatorSpace10,
                  Text(
                    'Summary',
                    style: titleStyle(context),
                  ),
                  separatorSpace10,
                  Text(
                    'A summary of your borrowings and repayments at a glance. Track the number of lenders you owe and ongoing repayments here.',
                    style: descriptionStyle(context),
                  ),
                  separatorSpace20,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
