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

  getRepayments(DocumentSnapshot documentSnapshot) {
    //Query Repayments
    StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('repayments')
          .where('userId', isEqualTo: userId)
          .where('loanId', isEqualTo: documentSnapshot.id)
          .snapshots(),
      builder: (context, rSnapshot) {
        int len = 0;
        if (rSnapshot.data?.docs.length != null) {
          len = rSnapshot.data!.docs.length;
        } else {
          len = 0;
        }
        double totalRepayments = 0;

        for (int j = 0; j < len; j++) {
          DocumentSnapshot repaymentSnapshot = rSnapshot.data!.docs[j];

          totalRepayments += repaymentSnapshot.get('amountRepaid');
        }
        return Container();
      },
    );
    //End of Repayment Query
  }
}
