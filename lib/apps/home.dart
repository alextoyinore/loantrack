import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loantrack/apps/loan_history_app.dart';
import 'package:loantrack/apps/widgets/homeview.dart';
import 'package:loantrack/helpers/colors.dart';
import 'package:loantrack/helpers/icons.dart';
import 'package:loantrack/widgets/loan_track_modal.dart';

import '../data/local.dart';
import '../widgets/application_grid_view.dart';

class LoanTrackHome extends StatefulWidget {
  const LoanTrackHome({Key? key}) : super(key: key);

  @override
  _LoanTrackHomeState createState() => _LoanTrackHomeState();
}

class _LoanTrackHomeState extends State<LoanTrackHome> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const HomeView(),
    const LoanHistoryApp(),
    const Center(
      child: Text('Page under construction'),
    ),
    const Center(
      child: Text('Page under construction'),
    ),
    const Center(
      child: Text('Page under construction'),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        //backgroundColor: LoanTrackColors.PrimaryTwoDark,
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white, //Colors.black12.withOpacity(0.03),
            elevation: 0,
            foregroundColor: LoanTrackColors.PrimaryTwoLight,
            leading: GestureDetector(
                onTap: () {
                  LoanTrackModal.modal(context,
                      content: const LoanTrackAppsGridView(),
                      title: 'Applications');
                },
                child: LoanTrackIcons.ApplicationIcon),
            title: Image.asset(
              'assets/images/loantrack.png',
              height: 20,
            ),
            /*Row(children: const [
              Text('LOAN', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(
                'TRACK',
                style: TextStyle(color: LoanTrackColors.PrimaryOne),
              ),
            ]),*/
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
                                      color: LoanTrackColors.PrimaryTwoLight),
                                  softWrap: true)),
                          title: 'About');
                    },
                    child: Icon(Icons.info_outline)),
              )
            ]),
        body: SafeArea(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: LoanTrackColors.PrimaryBlackLight,
          selectedItemColor: LoanTrackColors.PrimaryOne,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Colors.white //LoanTrackColors.PrimaryTwoDark,
                ),
            BottomNavigationBarItem(
                icon: Icon(Icons.history_edu),
                label: 'History',
                backgroundColor: Colors.white //LoanTrackColors.PrimaryTwoDark,
                ),
            BottomNavigationBarItem(
                icon: Icon(Icons.newspaper),
                label: 'News',
                backgroundColor: Colors.white //LoanTrackColors.PrimaryTwoDark,
                ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
                backgroundColor: Colors.white //LoanTrackColors.PrimaryTwoDark,
                ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Setting',
              backgroundColor: Colors.white,
            ),
          ],
          currentIndex: _selectedIndex,
          //selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
