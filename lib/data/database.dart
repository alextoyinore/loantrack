import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class DatabaseService with ChangeNotifier {
  // Collection reference
  final CollectionReference loans =
      FirebaseFirestore.instance.collection('loans');

  final CollectionReference repayments =
      FirebaseFirestore.instance.collection('repayments');

  final userId = FirebaseAuth.instance.currentUser!.uid;

  DatabaseService();

  Future updateLoanData({
    required double loanAmount,
    required double amountRepaid,
    required double interestRate,
    required double dailyOverdueCharge,
    required String applyWhen,
    required String dueWhen,
    required String lastPaidWhen,
    required String lenderType,
    required String lender,
    required String loanPurpose,
    required String note,
  }) async {
    return await loans.doc().set(
        {
          'userId': FirebaseAuth.instance.currentUser!.uid,
          'loanAmount': loanAmount,
          'amountRepaid': amountRepaid,
          'interestRate': interestRate,
          'dailyOverdueCharge': dailyOverdueCharge,
          'applyWhen': applyWhen,
          'dueWhen': dueWhen,
          'lastPaidWhen': lastPaidWhen,
          'lenderType': lenderType,
          'lender': lender,
          'loanPurpose': loanPurpose,
          'note': note
        },
        SetOptions(
          merge: true,
        ));
  }

  Future updateRepaymentData({
    required String loanId,
    required double amountRepaid,
    required String dateOfRepayment,
    required String note,
  }) async {
    return await repayments.doc().set({
      'userId': FirebaseAuth.instance.currentUser!.uid,
      'loanId': loanId,
      'amountRepaid': amountRepaid,
      'dateOfRepayment': dateOfRepayment,
      'note': note,
    }, SetOptions(merge: true));
  }

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getCollection(
      String collection) async {
    return FirebaseFirestore.instance.collection(collection).snapshots();
  }

  double totalRepayment(String loanId) {
    double totalRepayments = 0;
    StreamBuilder<QuerySnapshot>(
      stream: repayments
          .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          totalRepayments = 0;
        }
        int len = snapshot.data!.docs.length;

        for (int i = 0; i < len; i++) {
          if (snapshot.data!.docs[i].get('loanId') == loanId) {
            totalRepayments += snapshot.data!.docs[i].get('loanId');
          }
        }
        return Container();
      },
    );
    return totalRepayments;
  }
}
