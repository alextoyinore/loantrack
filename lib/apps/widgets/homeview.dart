import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loantrack/data/local.dart';
import 'package:loantrack/helpers/colors.dart';
import 'package:loantrack/widgets/bulleted_list.dart';
import 'package:loantrack/widgets/loan_progress_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Stack(children: [
      SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 16, top: 16, right: 16),
          height: screenHeight,
          child: Column(children: [
            // Name and avatar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(DateTime.now().toString(),
                        style: TextStyle(
                            color: LoanTrackColors.PrimaryTwoLight,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Welcome',
                            style: TextStyle(
                                color: LoanTrackColors.PrimaryTwoLight)),
                        Text(
                            FirebaseAuth.instance.currentUser!.displayName
                                .toString()
                                .toUpperCase(),
                            style: TextStyle(
                                color: LoanTrackColors.PrimaryTwoLight)),
                      ],
                    )
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  clipBehavior: Clip.hardEdge,
                  width: 65,
                  height: 65,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/user_profile.png'),
                      ),
                      borderRadius: BorderRadius.circular(50),
                      border:
                          Border.all(color: LoanTrackColors.PrimaryBlackLight)),
                )
              ],
            ),

            SizedBox(height: 20),

            // Loan card
            Container(
              width: screenWidth,
              //height: screenHeight / 2.9,
              padding: EdgeInsets.only(top: 16, bottom: 16),
              decoration: BoxDecoration(
                color:
                    LoanTrackColors.PrimaryOne, //LoanTrackColors.PrimaryBlack,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('CURRENT LOAN TOTAL',
                            style: TextStyle(color: Colors.white)),
                        SizedBox(height: 5),
                        Text('N 25,450.00',
                            style: TextStyle(fontSize: 36, color: Colors.white))
                      ],
                    ),
                  ),
                  const Divider(color: Colors.white, thickness: 1),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 8.0, left: 16, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'TOP LOANERS',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16),
                        ),
                        SizedBox(height: 5),
                        BulletedList(
                          text: 'LCREDIT - 25,000',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 5),
                        BulletedList(
                          text: '9CREDIT - 18,000',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BulletedList(
                              text: 'CASHBUS - 15,500',
                              style: TextStyle(
                                  color: LoanTrackColors.PrimaryOneLight),
                            ),
                            Text('OVERDUE',
                                style: TextStyle(
                                    color: LoanTrackColors.PrimaryOneLight))
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

            // Tracking header
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'TRACKING',
                    style: TextStyle(color: LoanTrackColors.PrimaryTwoLight),
                  ),
                  Text(
                    'SEE ALL',
                    style: TextStyle(color: LoanTrackColors.PrimaryOne),
                  )
                ],
              ),
            ),

            // Loan Progress
            SingleChildScrollView(
              child: Container(
                width: screenWidth,
                height: screenHeight / 3,
                child: ListView.builder(
                  //padding: const EdgeInsets.only(bottom: 10),
                  itemCount: LocalData.loans.length,
                  controller: _controller,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: LoanProgressBar(loan: LocalData.loans[index]),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 30)
          ]),
        ),
      ),

      // Action Buttons
      Positioned(
        bottom: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: screenWidth / 2,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              decoration: BoxDecoration(
                color: LoanTrackColors.PrimaryOne,
                //borderRadius: BorderRadius.circular(5),
              ),
              child: Text('Repayment Record',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
            ),
            Container(
              width: screenWidth / 2,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              decoration: BoxDecoration(
                color: LoanTrackColors.PrimaryTwoLight,
                //borderRadius: BorderRadius.circular(5),
              ),
              child: Text('Loan Record',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
            )
          ],
        ),
      )
    ]);
  }
}
