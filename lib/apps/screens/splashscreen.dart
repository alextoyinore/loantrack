import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loantrack/apps/login_app.dart';
import 'package:loantrack/apps/screens/onboarding.dart';

import '../providers/preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var duration = const Duration(seconds: 4);
    return Timer(duration, toLoginOrOnboarding);
  }

  bool onboarding = true;

  AppPreferences onboardingPreference = AppPreferences();

  Future<void> isOnboarding() async {
    bool onboardingValue = await onboardingPreference.getOnboarding();
    setState(() {
      onboarding = onboardingValue;
    });
  }

  toLoginOrOnboarding() {
    if (onboarding) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Onboarding()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoanTrackLogin()));
    }
  }

  @override
  void initState() {
    //implement initState
    super.initState();
    startTime();
    isOnboarding();
  }

  @override
  Widget build(BuildContext context) {
    print(onboarding);
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
