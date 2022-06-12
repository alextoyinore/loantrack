import 'package:flutter/material.dart';
import 'package:loantrack/apps/credit_score_app.dart';
import 'package:loantrack/apps/loan_list_app.dart';
import 'package:loantrack/apps/loan_record_app.dart';
import 'package:loantrack/apps/mail_and_messages_app.dart';
import 'package:loantrack/apps/notifications_app.dart';
import 'package:loantrack/apps/read_app.dart';
import 'package:loantrack/apps/repayment_list_app.dart';

import '../apps/loan_health_app.dart';
import '../apps/news_app.dart';
import '../apps/widgets/updateprofile.dart';
import 'apps.dart';

class LocalData {
  static const LoginInMessage =
      'Welcome to LoanTrack. We are your premier loan tracking and credit score company. '
      'Track your loans and repayments. Get loan advice, Follow loan news and more.';

  static final List<Apps> applicationList = [
    Apps(
      iconData: Icons.history_edu,
      name: 'Loans',
      destinationWidget: LoanTrackingPage(loanListHeight: -1, isHome: false),
    ),
    Apps(
      iconData: Icons.payment,
      name: 'Repayments',
      destinationWidget: const RepaymentHistory(),
    ),
    Apps(
        iconData: Icons.health_and_safety,
        name: 'Health',
        destinationWidget: const LoanHealth()),
    Apps(
        iconData: Icons.phone_in_talk,
        name: 'Read',
        destinationWidget: const Read()),
    Apps(
        iconData: Icons.money,
        name: 'New Loan',
        destinationWidget: LoanRecord(edit: false)),
    Apps(
        iconData: Icons.payments_rounded,
        name: 'Repay Loan',
        destinationWidget: LoanTrackingPage(loanListHeight: -1, isHome: false)),
    Apps(
        iconData: Icons.notifications_none_sharp,
        name: 'Notices',
        destinationWidget: const Notifications()),
    Apps(
        iconData: Icons.message,
        name: 'Email & Messages',
        destinationWidget: const EmailAndMessages()),
    Apps(
        iconData: Icons.newspaper,
        name: 'News',
        destinationWidget: const NewsApp()),
    Apps(
        iconData: Icons.numbers,
        name: 'Score',
        destinationWidget: const CreditScore()),
    Apps(
        iconData: Icons.person_outline,
        name: 'Edit Profile',
        destinationWidget: const ProfileUpdate()),
  ];

  static const aboutLoanTrack =
      'Loantrack was born out of the need for Nigerians and Africans to track their expenses, '
      'loans inclusive. As tech booms in Nigeria and other parts of Africa access to small and '
      'micro loans has become very easy. Nigerians and other African nationals are accessing loans '
      'to solve their daily problems and meet basic ends meet. \n\nThe problem is, '
      'with the ease of accessing loans comes the problem of loosing track of your borrowings '
      'which can eventually lead a user to humongous debts. \n\nAnother problem is that '
      'Loan companies use unorthodox tactics in reclaiming their money from users. '
      'Some of these tactics include embarrassing users with messages to their family members, '
      'work colleagues and religious friends thereby damaging their reputation and good name in the process. '
      'What is disheartening is that some of the amount this loan sharks humiliate people for are '
      'ridiculous at best. \n\nThese problems compounded with other issues that can be found in the '
      '"Motivation" section of our website is the reason for Loantrack. \n\nLoanTrack helps you track '
      'your borrowings and repayments and offers up-to-date, organic advice to its users to guide them in '
      'their dealings with these Loaners. \n\nSome of the features of Loantrack include Warnings, Cautions, '
      'and Advice within our Loan Advisory App. Loantrack tracks your loaning pattern and sends you messages '
      'and resources to help you borrow and still maintain your peace and mental health. \n\nThere is no '
      'shame in borrowing but given what is obtainable in Africa right now, having someone hold your hands '
      'through the journey can turn your loaning into a wealth creation and sustaining habit rather than a '
      'pit hole of problems for you and your family. \n\n\n\nLoanTrack is a product of The Letter Company.\n';
}
