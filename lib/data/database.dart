import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loantrack/models/loan.dart';
import 'package:loantrack/models/repayment.dart';
import 'package:loantrack/models/user.dart';

class DatabaseService {
  // Collection reference
  final CollectionReference loans =
      FirebaseFirestore.instance.collection('loans');

  final CollectionReference repayments =
      FirebaseFirestore.instance.collection('repayments');

  final CollectionReference blog =
      FirebaseFirestore.instance.collection('blog');

  final CollectionReference news =
      FirebaseFirestore.instance.collection('news');

  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference lenders =
      FirebaseFirestore.instance.collection('lenders');

  final userId = FirebaseAuth.instance.currentUser!.uid;

  DatabaseService();

  Future updateUserData({
    String? firstName,
    String? lastName,
    String? gender,
    String? married,
    String? isSamaritan,
    String? occupation,
    String? industry,
    String? entryDate,
    String? modifiedWhen,
    String? age,
    String? totalMonthlyIncome,
    String? profilePicture,
    String? countryOfResidence,
    String? cityOfResidence,
    String? nationality,
  }) async {
    return await users.doc().set(
      {
        'userId': userId,
        'firstname': firstName,
        'lastname': lastName,
        'gender': gender,
        'married': married,
        'isSamaritan': isSamaritan,
        'occupation': occupation,
        'industry': industry,
        'entryDate': entryDate,
        'modifiedWhen': DateTime.now().toIso8601String(),
        'age': age,
        'totalMonthlyIncome': totalMonthlyIncome,
        'profilePicture': profilePicture,
        'countryOfResidence': countryOfResidence,
        'cityOfResidence': cityOfResidence,
        'nationality': nationality,
      },
      SetOptions(merge: true),
    );
  }

  Future updateSingleUserData({
    required String id,
    String? firstName,
    String? lastName,
    String? gender,
    String? married,
    String? isSamaritan,
    String? occupation,
    String? industry,
    String? entryDate,
    String? modifiedWhen,
    String? age,
    String? totalMonthlyIncome,
    String? profilePicture,
    String? countryOfResidence,
    String? cityOfResidence,
    String? nationality,
  }) async {
    return await users.doc(id).update(
      {
        'userId': userId,
        'firstname': firstName,
        'lastname': lastName,
        'gender': gender,
        'married': married,
        'isSamaritan': isSamaritan,
        'occupation': occupation,
        'industry': industry,
        'entryDate': entryDate,
        'modifiedWhen': DateTime.now().toIso8601String(),
        'age': age,
        'totalMonthlyIncome': totalMonthlyIncome,
        'profilePicture': profilePicture,
        'countryOfResidence': countryOfResidence,
        'cityOfResidence': cityOfResidence,
        'nationality': nationality,
      },
    );
  }

  Stream<List<AppUser>> readUserProfileData() => FirebaseFirestore.instance
      .collection('users')
      .where('userId', isEqualTo: userId)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => AppUser.fromJSON(doc.data())).toList());

  Future updateLoanData({
    required double loanAmount,
    required double amountRepaid,
    required double interestRate,
    required double dailyOverdueCharge,
    required String applyWhen,
    required String dueWhen,
    required String lastPaidWhen,
    String? entryDate,
    String? modifiedWhen,
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
          'entryDate': DateTime.now().toIso8601String(),
          'modifiedWhen': DateTime.now().toIso8601String(),
          'lenderType': lenderType,
          'lender': lender,
          'loanPurpose': loanPurpose,
          'note': note
        },
        SetOptions(
          merge: true,
        ));
  }

  Stream<List<Loan>> readLoanData() => FirebaseFirestore.instance
      .collection('loans')
      .where('userId', isEqualTo: userId)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Loan.fromJSON(doc.data())).toList());

  Future updateSingleLoanData({
    required double loanAmount,
    required double amountRepaid,
    required double interestRate,
    required double dailyOverdueCharge,
    required String applyWhen,
    required String dueWhen,
    required String lastPaidWhen,
    required String entryDate,
    required String modifiedWhen,
    required String lenderType,
    required String lender,
    required String loanPurpose,
    required String note,
    required String id,
  }) async {
    return await loans.doc(id).update(
      {
        'userId': FirebaseAuth.instance.currentUser!.uid,
        'loanAmount': loanAmount,
        'amountRepaid': amountRepaid,
        'interestRate': interestRate,
        'dailyOverdueCharge': dailyOverdueCharge,
        'applyWhen': applyWhen,
        'dueWhen': dueWhen,
        'lastPaidWhen': lastPaidWhen,
        'entryDate': entryDate,
        'modifiedWhen': DateTime.now().toIso8601String(),
        'lenderType': lenderType,
        'lender': lender,
        'loanPurpose': loanPurpose,
        'note': note
      },
    );
  }

  Future updateRepaymentData({
    required String loanId,
    required double amountRepaid,
    required String repaidWhen,
    required String note,
    String? repaymentSlip,
  }) async {
    return await repayments.doc().set({
      'userId': FirebaseAuth.instance.currentUser!.uid,
      'loanId': loanId,
      'amountRepaid': amountRepaid,
      'repaidWhen': repaidWhen,
      'note': note,
      'repaymentSlip': repaymentSlip,
    }, SetOptions(merge: true));
  }

  Stream<List<Repayment>> readRepaymentData({required String loanId}) =>
      FirebaseFirestore.instance
          .collection('repayments')
          .where('userId', isEqualTo: userId)
          .where('loanId', isEqualTo: loanId)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => Repayment.fromJSON(doc.data()))
              .toList());
}
