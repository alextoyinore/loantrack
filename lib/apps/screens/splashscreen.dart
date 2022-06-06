import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loantrack/apps/login_app.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    //implement initState
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = const Duration(seconds: 4);
    return Timer(duration, toLogin);
  }

  toLogin() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const LoanTrackLogin()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.background,
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Image.asset(
            'assets/images/logo.png',
            scale: 5,
            //fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
