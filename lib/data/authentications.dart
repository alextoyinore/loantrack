import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:loantrack/apps/providers/login_states.dart';
import 'package:provider/provider.dart';

import 'database.dart';

//States loginState = States.loggedOut;

class AuthService {
  Future<void> checkEmailExists(
      {required BuildContext context,
      required String email,
      required Function(FirebaseAuthException e) errorCallback}) async {
    try {
      var methods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (methods.contains('password')) {
        context.read<LoginState>().passwordCheck();
      } else {
        context.read<LoginState>().createAccount();
      }
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  Future<void> signInWithEmailAndPassword(
      {required BuildContext context,
      required String email,
      required String password,
      required void Function(FirebaseAuthException e) errorCallback}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (FirebaseAuth.instance.currentUser!.emailVerified) {
        Navigator.pushNamed(context, '/home');
      } else {
        context.read<LoginState>().sendVerificationEmail();
      }
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  Future<void> forgotPassword(
      {required BuildContext context,
      required String email,
      required void Function(FirebaseAuthException e) errorCallback}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  Future<void> verifyUserEmail(
      {required BuildContext context,
      required String email,
      required void Function(FirebaseAuthException e) errorCallback}) async {}

  void cancelRegistration(BuildContext context) {
    context.read<LoginState>().cancel();
  }

  Future<void> registerAccount(
      {required BuildContext context,
      required String email,
      required String displayName,
      required String password,
      required void Function(FirebaseAuthException e) errorCallback}) async {
    try {
      var credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await credential.user!.updateDisplayName(displayName);
      DatabaseService databaseService = DatabaseService();
      databaseService.updateLoanData(
          loanAmount: 10,
          amountRepaid: 10,
          interestRate: 0,
          dailyOverdueCharge: 1,
          applyWhen: DateTime.now()
              .toString(), //DateTime.now().toString().substring(0, 10),
          dueWhen: DateTime.now().toString(),
          lastPaidWhen: DateTime.now().toString(),
          entryDate: DateTime.now().toString(),
          modifiedWhen: DateTime.now().toString(),
          lenderType: 'Test',
          lender: 'Test',
          loanPurpose: 'Test',
          note: 'Test');

      if (FirebaseAuth.instance.currentUser!.emailVerified) {
        Navigator.pushNamed(context, '/home');
      } else {
        context.read<LoginState>().sendVerificationEmail();
      }
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }
}
