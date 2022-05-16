import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loantrack/apps/providers/login_states.dart';
import 'package:loantrack/apps/widgets/button.dart';
import 'package:loantrack/data/authentications.dart';
import 'package:loantrack/data/local.dart';
import 'package:loantrack/helpers/colors.dart';
import 'package:loantrack/widgets/common_widgets.dart';
import 'package:loantrack/widgets/dialogs.dart';
import 'package:loantrack/widgets/loan_track_modal.dart';
import 'package:loantrack/widgets/loan_track_textfield.dart';
import 'package:provider/provider.dart';

class LoanTrackLogin extends StatefulWidget {
  const LoanTrackLogin({Key? key}) : super(key: key);

  @override
  State<LoanTrackLogin> createState() => _LoanTrackLoginState();
}

class _LoanTrackLoginState extends State<LoanTrackLogin> with ChangeNotifier {
  //Controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController displayNameController = TextEditingController();
  //FirebaseAuthException e = FirebaseAuthException(code: 'network-not-found');

  AuthService authService = AuthService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = const Duration(seconds: 4);
    return Timer(duration, runSplashScreen);
  }

  SizedBox runSplashScreen() {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Image.asset('assets/images/loantrack.png'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var currentTime;
    States loginState = context.watch<LoginState>().loginState;
    return WillPopScope(
      onWillPop: () async {
        DateTime now = DateTime.now();
        if (currentTime == null ||
            now.difference(currentTime) > const Duration(seconds: 2)) {
          //add duration of press gap
          currentTime = now;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                  'Press the Back Button again to Exit'))); //scaffold message, you can show Toast message too.
          return Future.value(false);
        }

        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: SingleChildScrollView(
              child: (loginState == States.loggedOut)
                  ? emailVerifier(context)
                  : (loginState == States.verifyingEmail)
                      ? emailVerifier(context)
                      : (loginState == States.askingPassword)
                          ? passwordRequest(context)
                          : (loginState == States.creatingAccount)
                              ? createAccount(context)
                              : (loginState == States.sendingVerificationEmail)
                                  ? sendingEmailVerificationScreen(context)
                                  : emailVerifier(context),
            ),
          ),
        ),
      ),
    );
  }

  loginHeader({required BuildContext context, String? message}) {
    return Column(
      children: [
        separatorSpace80,
        Image.asset(
          'assets/images/icon.png',
          scale: 48,
        ),
        separatorSpace50,
        Text(
          (message != null) ? message : '',
          style: const TextStyle(color: LoanTrackColors.PrimaryTwoVeryLight),
          softWrap: true,
          textAlign: TextAlign.center,
        ),
        separatorSpace20,
      ],
    );
  }

  startLoginFlow(BuildContext context) {
    return Column(
      children: [
        loginHeader(context: context, message: LocalData.LoginInMessage),
        GestureDetector(
            onTap: () {
              context.read<LoginState>().emailVerification();
            },
            child: LoanTrackButton.primary(
              context: context,
              label: 'Start',
            )),
        separatorSpace50,
        GestureDetector(
            onTap: () {
              LoanTrackModal.modal(context,
                  content: const SingleChildScrollView(
                    child: Text(LocalData.aboutLoanTrack,
                        style: TextStyle(
                            color: LoanTrackColors.PrimaryOne,
                            fontSize: 14,
                            height: 1.6)),
                  ),
                  title: 'About');
            },
            child: const Text(
              'About',
              style: TextStyle(
                  color: LoanTrackColors.PrimaryTwoVeryLight,
                  decoration: TextDecoration.underline),
            ))
      ],
    );
  }

  emailVerifier(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        loginHeader(
            context: context,
            message:
                'Like our expenditures and investments, your loans, tracked, will give you peace of mind and help you live a more fulfilling life.'),
        LoanTrackTextField(
          controller: emailController,
          label: 'Email',
          color: LoanTrackColors.PrimaryOne,
          //icon: const Icon(Icons.email, color: LoanTrackColors.PrimaryOne),
        ),
        separatorSpace10,
        GestureDetector(
          onTap: () {
            authService.checkEmailExists(
              context: context,
              email: emailController.text,
              errorCallback: (e) => showErrorDialog(
                context: context,
                title: 'Invalid Email',
                errorMessage:
                    'This email is not valid. Kindly check that you have typed a valid email.',
              ),
            );
          },
          child: LoanTrackButton.primary(
            context: context,
            label: 'Login',
          ),
        )
        //SizedBox(height: 10),
        //Text('Login process at ${context.watch<LoginState>().loginState}'),
      ],
    );
  }

  passwordRequest(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        loginHeader(
            context: context,
            message:
                'There is no shame in borrowing. Tracking your borrowings will keep them on top of your mind and in focus.'),
        LoanTrackTextField(
          controller: emailController,
          label: 'Email',
          color: LoanTrackColors.PrimaryOne,
          //icon: const Icon(Icons.email, color: LoanTrackColors.PrimaryOne),
        ),
        separatorSpace10,
        LoanTrackTextField(
          controller: passwordController,
          label: 'Password',
          isHidden: true,
          color: LoanTrackColors.PrimaryOne,
          //icon: const Icon(Icons.lock, color: LoanTrackColors.PrimaryOne),
        ),
        separatorSpace10,
        GestureDetector(
          onTap: () async {
            authService.signInWithEmailAndPassword(
                context: context,
                email: emailController.text,
                password: passwordController.text,
                errorCallback: (e) => showErrorDialog(
                    context: context,
                    title: 'Credential Error',
                    errorMessage:
                        'An error occured. Verify that your password is correctly typed.'));

            //Navigator.pushNamed(context, '/home');
          },
          child: LoanTrackButton.primary(
            context: context,
            label: 'Log In',
          ),
        ),
        separatorSpace10,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                authService
                    .forgotPassword(
                        context: context,
                        email: emailController.text,
                        errorCallback: (e) => showErrorDialog(
                              context: context,
                              title: 'Credential Error',
                              e: e,
                            ))
                    .whenComplete(() => showSuccessDialog(
                        successMessage:
                            'We sent you a password recovery link. Kindly follow the instruction in your email.',
                        context: context,
                        whenTapped: () => Navigator.of(context).pop(),
                        title: 'Email sent'));
              },
              child: const Text(
                'Forgot Password?',
                style: TextStyle(color: LoanTrackColors.PrimaryTwoVeryLight),
              ),
            ),
            GestureDetector(
              onTap: () {
                context.read<LoginState>().emailVerification();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: LoanTrackColors.PrimaryTwoVeryLight),
              ),
            ),
          ],
        )
      ],
    );
  }

  createAccount(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        loginHeader(
            context: context,
            message:
                'Start your journey now to a well-managed life. Whether it is living a loan-free life or just managing your loans properly, you\'ve come to the right place'),
        LoanTrackTextField(
          controller: emailController,
          label: 'Email',
          color: LoanTrackColors.PrimaryOne,
          // icon: const Icon(Icons.email, color: LoanTrackColors.PrimaryOne),
        ),
        separatorSpace10,
        LoanTrackTextField(
          controller: displayNameController,
          label: 'Username',
          color: LoanTrackColors.PrimaryOne,
          // icon: const Icon(Icons.person, color: LoanTrackColors.PrimaryOne),
        ),
        separatorSpace10,
        LoanTrackTextField(
          controller: passwordController,
          label: 'Password',
          isHidden: true,
          color: LoanTrackColors.PrimaryOne,
          //  icon: const Icon(Icons.lock, color: LoanTrackColors.PrimaryOne),
        ),
        separatorSpace10,
        GestureDetector(
          onTap: () {
            authService.registerAccount(
                context: context,
                email: emailController.text,
                displayName: displayNameController.text,
                password: passwordController.text,
                errorCallback: (e) => showErrorDialog(
                    context: context, title: 'Credential Error', e: e));
          },
          child: LoanTrackButton.primary(
            context: context,
            label: 'Create Account',
          ),
        ),
        separatorSpace10,
        GestureDetector(
          onTap: () {
            context.read<LoginState>().emailVerification();
          },
          child: LoanTrackButton.secondaryOutline(
            context: context,
            label: 'Cancel',
          ),
        ),
      ],
    );
  }

  sendingEmailVerificationScreen(BuildContext context) {
    return Column(
      children: [
        loginHeader(context: context),
        separatorSpace10,
        const Text(
          'We will send you a verification link. Click \'Request Link\' to get the email now.',
          textAlign: TextAlign.center,
        ),
        separatorSpace10,
        GestureDetector(
            onTap: () async {
              try {
                await FirebaseAuth.instance.currentUser
                    ?.sendEmailVerification();
                showSuccessDialog(
                    whenTapped: () {
                      Navigator.of(context).pop();
                      context.read<LoginState>().passwordCheck();
                    },
                    context: context,
                    title: 'Verification Sent',
                    successMessage:
                        'A verification link has been sent to you. Kindly check your email and follow the instructions.');
              } on FirebaseAuthException catch (e) {
                showErrorDialog(context: context, title: 'Request Error', e: e);
              }
              //context.read<LoginState>().passwordCheck();
            },
            child: LoanTrackButton.primary(
              context: context,
              label: 'Request Link',
            )),
        separatorSpace10,
        GestureDetector(
          onTap: () {
            context.read<LoginState>().passwordCheck();
          },
          child: const Text(
            'I have a link already and I\'ve confirmed my email',
            style: TextStyle(color: LoanTrackColors.PrimaryOne),
          ),
        )
      ],
    );
  }
}
