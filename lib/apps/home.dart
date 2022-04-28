import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loantrack/apps/app_settings.dart';
import 'package:loantrack/apps/loan_tracking_page.dart';
import 'package:loantrack/apps/news.dart';
import 'package:loantrack/apps/widgets/homeview.dart';
import 'package:loantrack/helpers/colors.dart';

class LoanTrackHome extends StatefulWidget {
  const LoanTrackHome({Key? key}) : super(key: key);

  @override
  _LoanTrackHomeState createState() => _LoanTrackHomeState();
}

class _LoanTrackHomeState extends State<LoanTrackHome> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    List<Widget> _widgetOptions = <Widget>[
      const HomeView(),
      LoanTrackingPage(isHome: true, loanListHeight: screenHeight / 1.76),
      const Center(
        child: News(),
      ),
      const Center(
        child: Text('Page under construction'),
      ),
      const AppSettings(),
    ];

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor:
              LoanTrackColors.PrimaryTwoVeryLight.withOpacity(.3),
          selectedItemColor: LoanTrackColors.PrimaryOne,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
                backgroundColor: Colors.white //LoanTrackColors.PrimaryTwoDark,
                ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history_edu),
              label: 'History',
              backgroundColor: Colors.white, //LoanTrackColors.PrimaryTwoDark,
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.newspaper_outlined),
                label: 'News',
                backgroundColor: Colors.white //LoanTrackColors.PrimaryTwoDark,
                ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'Profile',
                backgroundColor: Colors.white //LoanTrackColors.PrimaryTwoDark,
                ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
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
