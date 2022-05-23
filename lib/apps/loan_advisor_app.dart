import 'package:flutter/material.dart';
import 'package:loantrack/helpers/colors.dart';
import 'package:loantrack/helpers/listwidgets.dart';
import 'package:loantrack/widgets/common_widgets.dart';

class LoanAdvisor extends StatefulWidget {
  const LoanAdvisor({Key? key}) : super(key: key);

  @override
  State<LoanAdvisor> createState() => _LoanAdvisorState();
}

class _LoanAdvisorState extends State<LoanAdvisor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: LoanTrackColors.PrimaryOne,
        elevation: 0,
        title: const Text('Loan Advisor'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            separatorSpace5,
            const Padding(
              padding: EdgeInsets.only(left: 24.0),
              child: Text(
                'Get tips, advice, and loan guidance content here',
                style: TextStyle(
                  color: LoanTrackColors.PrimaryTwoVeryLight,
                ),
              ),
            ),
            //separatorSpace10,
            BlogList(height: MediaQuery.of(context).size.height * .83),
          ],
        ),
      ),
    );
  }
}
