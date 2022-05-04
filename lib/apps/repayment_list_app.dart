import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loantrack/helpers/functions.dart';

class RepaymentHistory extends StatefulWidget {
  const RepaymentHistory({Key? key}) : super(key: key);

  @override
  State<RepaymentHistory> createState() => _RepaymentHistoryState();
}

class _RepaymentHistoryState extends State<RepaymentHistory> {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: RepaymentBulletedList(
          height: MediaQuery.of(context).size.height * .7, userId: userId),
    ));
  }
}
