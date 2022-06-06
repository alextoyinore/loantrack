import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loantrack/helpers/colors.dart';
import 'package:loantrack/helpers/styles.dart';
import 'package:loantrack/widgets/common_widgets.dart';

import '../helpers/listwidgets.dart';

class LoanTrackingPage extends StatefulWidget {
  LoanTrackingPage(
      {Key? key,
      required this.loanListHeight,
      this.numberOfItems,
      required this.isHome})
      : super(key: key);

  double loanListHeight;
  bool isHome;
  int? numberOfItems;

  @override
  State<LoanTrackingPage> createState() => _LoanTrackingPageState();
}

class _LoanTrackingPageState extends State<LoanTrackingPage> {
  double totalRepaid = 0;
  double totalInLoan = 0;

  String userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 24.0, left: 24, right: 24),
          //margin: const EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (widget.isHome == false)
                  ? GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.close),
                        ],
                      ),
                    )
                  : const SizedBox(
                      height: 0,
                    ),
              (widget.isHome == false)
                  ? separatorSpace10
                  : const SizedBox(
                      height: 0,
                    ),
              Text('Loan List', style: titleStyle(context)),
              separatorSpace10,

              const Text(
                'Select a loan from the list to \'Edit\' or \'Make Repayment\' ',
                style: TextStyle(color: LoanTrackColors.PrimaryTwoVeryLight),
              ),
              separatorSpace20,

              //Loan list
              SingleChildScrollView(
                child: LoanList(
                    userId: userId,
                    width: screenWidth,
                    height: (widget.loanListHeight > 0)
                        ? widget.loanListHeight
                        : screenHeight * .7),
              ),
              separatorSpace10,
            ],
          ),
        ),
      ),
    );
  }
}
