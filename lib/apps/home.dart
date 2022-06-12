import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loantrack/apps/loan_list_app.dart';
import 'package:loantrack/apps/settings_app.dart';
import 'package:loantrack/apps/widgets/homeview.dart';
import 'package:loantrack/apps/widgets/user_profile.dart';

import '../data/authentications.dart';

class LoanTrackHome extends StatefulWidget {
  LoanTrackHome({Key? key, this.selectedIndex}) : super(key: key);

  int? selectedIndex;

  @override
  _LoanTrackHomeState createState() => _LoanTrackHomeState();
}

class _LoanTrackHomeState extends State<LoanTrackHome> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    List<Widget> _widgetOptions = <Widget>[
      const HomeView(),
      LoanTrackingPage(
        fromRepayment: false,
        isHome: true,
        loanListHeight: screenHeight / 1.45,
      ),
      const Center(
        child: UserProfile(),
      ),
      const AppSettings(),
    ];

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    var currentTime;

    return WillPopScope(
      onWillPop: () async {
        DateTime now = DateTime.now();
        if (currentTime == null ||
            now.difference(currentTime) > const Duration(seconds: 2)) {
          //add duration of press gap
          currentTime = now;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Press Back Button again to Logout')));
          AuthService auth = AuthService();
          auth.signOut();
          //scaffold message, you can show Toast message too.
          return Future.value(false);
        }

        return Future.value(true);
      },
      child: Scaffold(
        body: SafeArea(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history_edu),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              label: 'Setting',
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
