import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loantrack/helpers/listwidgets.dart';
import 'package:loantrack/widgets/common_widgets.dart';

import '../helpers/styles.dart';

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
      child: Column(
        children: [
          separatorSpace30,
          Container(
            color: Theme.of(context).colorScheme.background,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  separatorSpace20,
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.close),
                      ],
                    ),
                  ),
                  separatorSpace10,
                  Text(
                    'All Repayments',
                    style: titleStyle(context),
                  ),
                  separatorSpace10,
                  Text(
                    'Welcome to the Repayments App. Here you can see a history of all your repayments.',
                    style: descriptionStyle(context),
                  ),
                  separatorSpace20,
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            child: RepaymentBulletedList(
                height: MediaQuery.of(context).size.height * .6,
                userId: userId),
          ),
          separatorSpace200,
        ],
      ),
    ));
  }
}
