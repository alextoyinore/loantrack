import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:loantrack/models/lender.dart';

enum LenderType { Loan_App, Bank_MFB, Family_Friends }

class Loan {
  //Identifiers
  String id;
  String userId;

  // Money
  double loanAmount;
  double? amountRepaid;
  double? interestRate;
  double? dailyOverdueCharge;

  // Dates
  DateTime? applyWhen;
  DateTime? dueWhen;
  DateTime? lastPaidWhen;
  DateTime? entryDate;
  DateTime? modifiedWhen;

  // Lender
  LenderType lenderType;
  Lender lender;

  // Notes
  String? loanPurpose;
  String? note;

  Loan({
    // Identifiers
    this.id = '',
    this.userId = '',

    //Money
    required this.loanAmount,
    required this.interestRate,
    this.amountRepaid = 0,
    this.dailyOverdueCharge = 0,

    // Dates
    this.applyWhen,
    this.dueWhen,
    this.lastPaidWhen,
    this.entryDate,
    this.modifiedWhen,

    // Lender
    required this.lender,
    this.lenderType = LenderType.Loan_App,

    //notes
    this.loanPurpose,
    this.note,
  });

  Map<String, dynamic> toJSON() => {
        'id': '',
        'userId': FirebaseAuth.instance.currentUser!.uid,
        'loanAmount': loanAmount,
        'interestRate': interestRate,
        'amountRepaid': amountRepaid,
        'dailyOverdueCharge': dailyOverdueCharge,
        'applyWhen': applyWhen,
        'dueWhen': dueWhen,
        'lastPaidWhen': lastPaidWhen,
        'entryDate': entryDate,
        'modifiedWhen': modifiedWhen,
        'lender': lender,
        'lenderType': lenderType,
        'loanPurpose': loanPurpose,
        'note': note,
      };

  static Loan fromJSON(Map<String, dynamic> data) => Loan(
        id: data['id'],
        userId: data['userId'],
        loanAmount: data['loanAmount'],
        interestRate: data['interestRate'],
        amountRepaid: data['amountRepaid'],
        dailyOverdueCharge: data['dailyOverdueCharge'],
        applyWhen: data['applyWhen'],
        dueWhen: data['dueWhen'],
        lastPaidWhen: data['lastPaidWhen'],
        entryDate: data['entryDate'],
        modifiedWhen: data['modifiedWhen'],
        lender: data['lender'],
        lenderType: data['lenderType'],
        loanPurpose: data['loanPurpose'],
        note: data['note'],
      );

  String loanInfo(String formatter) {
    return lender.name +
        ': ' +
        formatter +
        ' LOAN: ' +
        loanAmount.toString() +
        ' ' +
        formatter +
        ' REPAID: ' +
        amountRepaid.toString();
  }
}
