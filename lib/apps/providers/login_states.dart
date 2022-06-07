import 'package:flutter/material.dart';

enum States {
  loggedOut,
  verifyingEmail,
  askingPassword,
  creatingAccount,
  sendingVerificationEmail,
  loggedIn
}

class LoginState with ChangeNotifier {
  /* LoginState() {
    init();
  }

  //Initialize Firebase
  Future<void> init() async {
    await Firebase.initializeApp();
  }*/

  States _loginState = States.loggedOut;
  States get loginState => _loginState;

  void emailVerification() {
    _loginState = States.verifyingEmail;
    notifyListeners();
  }

  void passwordCheck() {
    _loginState = States.askingPassword;
    notifyListeners();
  }

  void createAccount() {
    _loginState = States.creatingAccount;
    notifyListeners();
  }

  void sendVerificationEmail() {
    _loginState = States.sendingVerificationEmail;
    notifyListeners();
  }

  void loggedIn() {
    _loginState = States.loggedIn;
    notifyListeners();
  }

  void cancel() {
    _loginState = States.verifyingEmail;
  }

  void startLoginFlow() {
    _loginState = States.loggedOut;
  }
}
