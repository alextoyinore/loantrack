import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loantrack/data/loan.dart';
import 'package:loantrack/data/loaner.dart';
import 'package:loantrack/helpers/colors.dart';
import 'package:loantrack/helpers/icons.dart';
import 'package:loantrack/structures/interface-ish.dart';
import 'package:loantrack/widgets/applications_bottom_modal.dart';
import 'package:loantrack/widgets/bulleted_list.dart';
import 'package:loantrack/widgets/loan_progress_bar.dart';

class LoanTrackHome extends StatefulWidget implements Apps {
  const LoanTrackHome({Key? key}) : super(key: key);

  @override
  _LoanTrackHomeState createState() => _LoanTrackHomeState();
}

class _LoanTrackHomeState extends State<LoanTrackHome> {
  // List of loans
  List<Loan> loans = [
    Loan(
      loanAmount: 25000,
      amountRepaid: 5000,
      loaner: Loaner(name: 'LCREDIT'),
      interestRate: 7,
    ),
    Loan(
      loanAmount: 20000,
      amountRepaid: 12000,
      loaner: Loaner(name: 'CASHMALL'),
      interestRate: 10,
    ),
    Loan(
      loanAmount: 35000,
      amountRepaid: 12000,
      loaner: Loaner(name: '9CREDIT'),
      interestRate: 7,
    ),
    Loan(
      loanAmount: 32000,
      amountRepaid: 19000,
      loaner: Loaner(name: 'CASHCREDIT'),
      interestRate: 16,
    ),
    Loan(
      loanAmount: 8000,
      amountRepaid: 8000,
      loaner: Loaner(name: 'QUICKCREDIT'),
      interestRate: 10,
    ),
    Loan(
      loanAmount: 4000,
      amountRepaid: 2000,
      loaner: Loaner(name: 'NCREDIT'),
      interestRate: 10,
    ),
  ];

  //
  ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.black12.withOpacity(0.03),
            elevation: 0,
            foregroundColor: Colors.black,
            leading: GestureDetector(
                onTap: () {
                  LoanTrackModal.applicationsModal(context);
                },
                child: LoanTrackIcons.ApplicationIcon),
            title: Row(children: const [
              Text('LOAN', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(
                'TRACK',
                style: TextStyle(color: LoanTrackColors.PrimaryOne),
              ),
            ]),
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: Icon(Icons.info_outline),
              )
            ]),
        body: Stack(children: [
          SingleChildScrollView(
              padding: EdgeInsets.only(left: 16, top: 16, right: 16),
              child: Column(children: [
                // Name and avatar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('04, April 2022',
                            style: TextStyle(
                                color: LoanTrackColors.PrimaryBlack,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('WELCOME',
                                style: TextStyle(
                                    color: LoanTrackColors.PrimaryBlack)),
                            Text('ADEPEJU WILLIAMS',
                                style: TextStyle(
                                    color: LoanTrackColors.PrimaryBlack)),
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
                          border: Border.all(
                              color: LoanTrackColors.PrimaryBlackLight)),
                    )
                  ],
                ),

                SizedBox(height: 20),

                // Loan card
                Container(
                  width: screenWidth,
                  height: screenHeight / 2.9,
                  padding: EdgeInsets.only(top: 16, bottom: 16),
                  decoration: BoxDecoration(
                    color: LoanTrackColors.PrimaryOne,
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
                                style: TextStyle(
                                    fontSize: 36, color: Colors.white))
                          ],
                        ),
                      ),
                      const Divider(color: Colors.white, thickness: 1),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 16, right: 16),
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
                              text: 'CASHMALL - 22,000',
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
                                      color: LoanTrackColors.PrimaryTwoLight),
                                ),
                                Text('OVERDUE',
                                    style: TextStyle(
                                        color: LoanTrackColors.PrimaryTwoLight))
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BulletedList(
                                  text: 'LOANNAIRA - 12,500',
                                  style: TextStyle(
                                      color: LoanTrackColors.PrimaryTwoLight),
                                ),
                                Text('OVERDUE',
                                    style: TextStyle(
                                        color: LoanTrackColors.PrimaryTwoLight))
                              ],
                            ),
                            SizedBox(height: 5),
                            BulletedList(
                              text: 'QUICKCREDIT - 9,500',
                              style: TextStyle(color: Colors.white),
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
                        style: TextStyle(color: LoanTrackColors.PrimaryBlack),
                      ),
                      Text(
                        'SEE ALL',
                        style: TextStyle(color: LoanTrackColors.PrimaryOne),
                      )
                    ],
                  ),
                ),

                // Loan Progress
                Container(
                  width: screenWidth,
                  height: screenHeight / 3,
                  child: ListView.builder(
                    //padding: const EdgeInsets.only(bottom: 10),
                    itemCount: loans.length,
                    controller: _controller,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: LoanProgressBar(loan: loans[index]),
                      );
                    },
                  ),
                ),
                SizedBox(height: 30)
              ])),

          // Action Buttons
          Positioned(
            bottom: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: screenWidth / 2,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
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
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  decoration: BoxDecoration(
                    color: LoanTrackColors.PrimaryTwo,
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
        ]),
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: LoanTrackColors.PrimaryBlackLight,
          selectedItemColor: LoanTrackColors.PrimaryOne,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.history_edu), label: 'History'),
            BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: 'News'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Setting'),
          ],
        ),
      ),
    );
  }
}
