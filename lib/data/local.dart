import 'package:flutter/material.dart';
import 'package:loantrack/models/loan.dart';
import 'package:loantrack/models/loaner.dart';

import 'apps.dart';

class LocalData {
  static final LoginInMessage = '';

  static final List<Loan> loans = [
    Loan(
      loanAmount: 25000,
      amountRepaid: 5000,
      loaner: Loaner(name: 'LCREDIT'),
      interestRate: 7,
      applyDate: DateTime.utc(2022, DateTime.march, 15),
      dueDate: DateTime.utc(2022, DateTime.march, 30),
      lastPaymentDate: DateTime.utc(2022, DateTime.march, 6),
    ),
    Loan(
      loanAmount: 20000,
      amountRepaid: 12000,
      loaner: Loaner(name: 'CASHMALL'),
      interestRate: 10,
      applyDate: DateTime(2022, 3, 10),
      dueDate: DateTime(2022, 3, 25),
      lastPaymentDate: DateTime(2022, 4, 1),
    ),
    Loan(
      loanAmount: 35000,
      amountRepaid: 12000,
      loaner: Loaner(name: '9CREDIT'),
      interestRate: 7,
      applyDate: DateTime(2022, 3, 5),
      dueDate: DateTime(2022, 3, 12),
      lastPaymentDate: DateTime(2022, 3, 10),
    ),
    Loan(
      loanAmount: 32000,
      amountRepaid: 19000,
      loaner: Loaner(name: 'CASHCREDIT'),
      interestRate: 16,
      applyDate: DateTime(2022, 3, 15),
      dueDate: DateTime(2022, 3, 22),
      lastPaymentDate: DateTime(2022, 3, 20),
    ),
    Loan(
      loanAmount: 8000,
      amountRepaid: 8000,
      loaner: Loaner(name: 'QUICKCREDIT'),
      interestRate: 10,
      applyDate: DateTime(2022, 3, 15),
      dueDate: DateTime(2022, 3, 22),
      lastPaymentDate: DateTime(2022, 3, 21),
    ),
    Loan(
      loanAmount: 4000,
      amountRepaid: 2000,
      loaner: Loaner(name: 'NCREDIT'),
      interestRate: 10,
      applyDate: DateTime(2022, 6, 15),
      dueDate: DateTime(2022, 3, 15),
      lastPaymentDate: DateTime(2022, 4, 6),
    ),
    Loan(
      loanAmount: 9000,
      amountRepaid: 2000,
      loaner: Loaner(name: 'CASHRAIN'),
      interestRate: 10,
      applyDate: DateTime(2022, 2, 15),
      dueDate: DateTime(2022, 2, 22),
      lastPaymentDate: DateTime(2022, 2, 18),
    ),
    Loan(
      loanAmount: 4000,
      amountRepaid: 3000,
      loaner: Loaner(name: '9RALOAN'),
      interestRate: 10,
      applyDate: DateTime(2022, 1, 15),
      dueDate: DateTime(2022, 1, 22),
      lastPaymentDate: DateTime(2022, 1, 22),
    ),
    Loan(
      loanAmount: 4000,
      amountRepaid: 4000,
      loaner: Loaner(name: 'HCASH'),
      interestRate: 10,
      applyDate: DateTime(2022, 1, 15),
      dueDate: DateTime(2022, 1, 22),
      lastPaymentDate: DateTime(2022, 1, 22),
    ),
    Loan(
      loanAmount: 8000,
      amountRepaid: 6000,
      loaner: Loaner(name: 'SNAPPYCREDIT'),
      interestRate: 10,
      applyDate: DateTime(2022, 1, 10),
      dueDate: DateTime(2022, 1, 17),
      lastPaymentDate: DateTime(2022, 1, 16),
    ),
    Loan(
      loanAmount: 4000,
      amountRepaid: 4000,
      loaner: Loaner(name: 'PROCASH'),
      interestRate: 10,
      applyDate: DateTime(2022, 1, 15),
      dueDate: DateTime(2022, 1, 22),
      lastPaymentDate: DateTime(2022, 1, 22),
    ),
    Loan(
      loanAmount: 4000,
      amountRepaid: 4000,
      loaner: Loaner(name: 'NCASH'),
      interestRate: 10,
      applyDate: DateTime(2022, 1, 15),
      dueDate: DateTime(2022, 1, 22),
      lastPaymentDate: DateTime(2022, 1, 22),
    ),
  ];

  static final List<Apps> applicationList = [
    Apps(iconData: Icons.history_edu, name: 'Loan History'),
    Apps(iconData: Icons.payment, name: 'Repayment History'),
    Apps(iconData: Icons.assignment_returned, name: 'Reconciliations'),
    Apps(iconData: Icons.calendar_month, name: 'Promises'),
    Apps(iconData: Icons.health_and_safety, name: 'Loan Health'),
    Apps(iconData: Icons.phone_in_talk, name: 'Loan Advisor'),
    Apps(iconData: Icons.money, name: 'Loan Record'),
    Apps(iconData: Icons.payments_rounded, name: 'Payment Record'),
    Apps(iconData: Icons.pattern, name: 'Loan Pattern'),
    Apps(iconData: Icons.notifications_none_sharp, name: 'Notifications'),
    Apps(iconData: Icons.message, name: 'Email & Messages'),
    Apps(iconData: Icons.newspaper, name: 'News'),
    Apps(iconData: Icons.numbers, name: 'Credit Score'),
  ];

  static const aboutLoanTrack =
      'LoanTrack was born out of the need for Nigerians and Africans to track their expenses, loans inclusive. As tech booms in Nigeria and other parts of Africa access to small and micro loans has become very easy. Nigerians and other African nationals are accessing loans to solve their daily problems and meet basic ends meet. \n\nThe problem is, with the ease of accessing loans comes the problem of loosing track of your borrowings which can eventually lead a user to humongous debts. \n\nAnother problem is that Loan companies use unorthodox tactics in reclaiming their money from users. Some of these tactics include embarrasing users with messages to their family members, work colleagues and religious friends thereby damaging their reputation and good name in the process. What is disheartning is that some of the amount this loan sharks humiliate people for are ridiculous at best. \n\nThese problems compounded with other issues that can be found in the "Motivation" section of our website is the reason for LoanTrack. \n\nLoanTrack helps you track your borrowings and repayments and offers up-to-date, organic advice to its users to guide them in their dealings with these Loaners. \n\nSome of the features of LoanTrack include Warnings, Cautions, and Advice within our Loan Advisory App. LoanTrack tracks your loaning pattern and sends you messages and resources to help you borrow and still maintain your peace and mental health. \n\nThere is no shame in borrowing but given what is obtainable in Africa right now, having someone hold your hands through the journey can turn your loaning into a wealth creation and sustaining habit rather than a pit hole of problems for you and your family. \n\n\n\nLoanTrack is a product of The Letter Company.';
}
