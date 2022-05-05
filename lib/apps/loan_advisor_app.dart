import 'package:flutter/material.dart';
import 'package:loantrack/helpers/colors.dart';
import 'package:loantrack/helpers/common_widgets.dart';
import 'package:loantrack/helpers/functions.dart';

class LoanAdvisor extends StatefulWidget {
  const LoanAdvisor({Key? key}) : super(key: key);

  @override
  State<LoanAdvisor> createState() => _LoanAdvisorState();
}

class _LoanAdvisorState extends State<LoanAdvisor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            separatorSpace50,
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'LOAN ADVISOR',
                    style: TextStyle(
                      fontSize: 20,
                      color: LoanTrackColors.PrimaryOne,
                    ),
                  )
                ],
              ),
            ),
            separatorSpace10,
            const Padding(
              padding: EdgeInsets.only(left: 24.0),
              child: Text(
                'Get tips, advice, and guidance content here',
                style: TextStyle(
                  color: LoanTrackColors.PrimaryTwoVeryLight,
                ),
              ),
            ),
            separatorSpace10,
            BlogList(height: MediaQuery.of(context).size.height * .77),
          ],
        ),
      ),
    );
  }
}
