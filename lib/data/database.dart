import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class DatabaseService with ChangeNotifier {
  // Collection reference
  final CollectionReference loans =
      FirebaseFirestore.instance.collection('loans');

  DatabaseService();

  Future updateLoanData({
    required String loanAmount,
    required String amountRepaid,
    required String interestRate,
    required String applyWhen,
    required String dueWhen,
    required String lastPaidWhen,
    required String loanType,
    required String loaner,
    required String loanPurpose,
    required String note,
  }) async {
    return await loans.doc().set({
      'userId': FirebaseAuth.instance.currentUser!.uid,
      'loanAmount': loanAmount,
      'amountRepaid': amountRepaid,
      'interestRate': interestRate,
      'applyWhen': applyWhen,
      'dueWhen': dueWhen,
      'lastPaidWhen': lastPaidWhen,
      'loanType': loanType,
      'loaner': loaner,
      'loanPurpose': loanPurpose,
      'note': note
    });
  }

  static String getTotalAmount(BuildContext context) {
    double totalLoans = 0;
    final loans = Provider.of<QuerySnapshot>(context);
    for (var doc in loans.docs) {
      totalLoans += double.parse(doc.get('loanAmount'));
    }

    return totalLoans.toString();
  }
}
