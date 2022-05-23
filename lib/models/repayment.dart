import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Repayment {
  String? id;
  String userId;
  String loanId;
  double amountRepaid;
  String repaidWhen;
  DateTime? entryDate;
  DateTime? modifiedWhen;
  String? note;
  String? repaymentSlip;

  Repayment({
    this.id,
    required this.userId,
    required this.loanId,
    required this.amountRepaid,
    required this.repaidWhen,
    this.entryDate,
    this.modifiedWhen,
    this.note,
    this.repaymentSlip,
  });

  Map<String, dynamic> toJSON() => {
        'id': '',
        'userId': FirebaseAuth.instance.currentUser!.uid,
        'loanId': loanId,
        'amountRepaid': amountRepaid,
        'repaidWhen': repaidWhen,
        'entryDate': entryDate,
        'modifiedWhen': modifiedWhen,
        'note': note,
      };

  static Repayment fromJSON(Map<String, dynamic> data) => Repayment(
        id: data['id'],
        userId: data['userId'],
        loanId: data['loanId'],
        amountRepaid: data['amountRepaid'],
        repaidWhen: data['repaidWhen'],
        entryDate: data['entryDate'],
        modifiedWhen: data['modifiedWhen'],
        note: data['note'],
      );
}
