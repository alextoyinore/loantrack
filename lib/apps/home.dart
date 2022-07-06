import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loantrack/apps/loan_list_app.dart';
import 'package:loantrack/apps/providers/login_states.dart';
import 'package:loantrack/apps/settings_app.dart';
import 'package:loantrack/apps/widgets/homeview.dart';
import 'package:loantrack/apps/widgets/user_profile.dart';
import 'package:loantrack/helpers/styles.dart';
import 'package:loantrack/widgets/common_widgets.dart';
import 'package:provider/provider.dart';

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
  void initState() {
    super.initState();
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('A new onMessageOpenedApp event was published!');
      }
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text(notification.title!),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(notification.body!),
                  ],
                ),
              ),
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    List<Widget> _widgetOptions = <Widget>[
      const HomeView(),
      LoanTrackingPage(
        fromRepayment: false,
        isHome: true,
        loanListHeight:
            (screenWidth < 400) ? screenHeight / 1.41 : screenHeight / 1.45,
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

    //var currentTime = DateTime.now();

    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Text(
                'Where to?',
                style: smallTitleStyle(context),
              ),
              content: Container(
                height: screenHeight / 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'What would you like to do? Whether you are signing out or exiting the app, remember your loans do not devalue you. You are the best!',
                      style: smallerTitleStyle(context),
                    ),
                    separatorSpace20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all<double?>(0),
                          ),
                          onPressed: () {
                            AuthService auth = AuthService();
                            auth.signOut();
                            context.read<LoginState>().emailVerification();
                            Navigator.pushNamed(context, '/login');
                            Future.value(true);
                          },
                          child: Text(
                            '  Sign Out  ',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        OutlinedButton(
                          child: Text(
                            '  Exit App  ',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          onPressed: () {
                            SystemNavigator.pop();
                            //Future.value(true);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );

        return Future.value(false);
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
