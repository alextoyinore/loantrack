import 'package:flutter/material.dart';
import 'package:loantrack/helpers/colors.dart';
import 'package:loantrack/widgets/common_widgets.dart';
import 'package:loantrack/helpers/listwidgets.dart';

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
                children: const [
                  Icon(
                    Icons.call,
                    color: LoanTrackColors.PrimaryOne,
                    size: 20,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'LOAN ADVISOR',
                    style: TextStyle(
                        color: LoanTrackColors.PrimaryOne, fontSize: 20),
                  )
                ],
              ),
            ),
            separatorSpace10,
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
            BlogList(height: MediaQuery.of(context).size.height * .86),
          ],
        ),
      ),
    );
  }
}
