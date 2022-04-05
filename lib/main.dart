import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loantrack/apps/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LOANTRACK',
      theme: ThemeData(
        // This is the theme of your application.
        textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: LoanTrackHome(),
      ),
    );
  }
}
