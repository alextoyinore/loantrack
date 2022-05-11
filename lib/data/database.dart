import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loantrack/apps/providers/user.dart';

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

  final CollectionReference userProfile =
      FirebaseFirestore.instance.collection('users');

  final userId = FirebaseAuth.instance.currentUser!.uid;

  DatabaseService();

  Future updateUserProfile({
    String? firstName,
    String? lastName,
    String? gender,
    bool? married,
    bool? isSamaritan,
    String? occupation,
    double? age,
    double? totalMonthlyIncome,
    String? profilePicture,
    String? countryOfResidence,
    String? cityOfResidence,
    String? nationality,
  }) async {
    return await userProfile.doc().set(
      {
        'userId': userId,
        'firstname': firstName,
        'lastname': lastName,
        'gender': gender,
        'married': married,
        'isSamaritan': isSamaritan,
        'occupation': occupation,
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

  Stream<List<AppUser>> readData() => FirebaseFirestore.instance
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
    required String entryDate,
    required String modifiedWhen,
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
          'entryDate': entryDate,
          'modifiedWhen': modifiedWhen,
          'lenderType': lenderType,
          'lender': lender,
          'loanPurpose': loanPurpose,
          'note': note
        },
        SetOptions(
          merge: true,
        ));
  }

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
    return await loans.doc(id).set(
        {
          'userId': FirebaseAuth.instance.currentUser!.uid,
          'loanAmount': loanAmount,
          'amountRepaid': amountRepaid,
          'interestRate': interestRate,
          'dailyOverdueCharge': dailyOverdueCharge,
          'applyWhen': applyWhen,
          'dueWhen': dueWhen,
          'lastPaidWhen': lastPaidWhen,
          'entryDate': DateTime.now().toString().substring(0, 10),
          'modifiedWhen': modifiedWhen,
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
    String? repaymentSlip,
  }) async {
    return await repayments.doc().set({
      'userId': FirebaseAuth.instance.currentUser!.uid,
      'loanId': loanId,
      'amountRepaid': amountRepaid,
      'dateOfRepayment': dateOfRepayment,
      'note': note,
      'repaymentSlip': repaymentSlip,
    }, SetOptions(merge: true));
  }
}
