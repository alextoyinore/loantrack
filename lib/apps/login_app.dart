import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loantrack/apps/messages/notifications.dart';
import 'package:loantrack/apps/providers/login_states.dart';
import 'package:loantrack/apps/widgets/button.dart';
import 'package:loantrack/data/authentications.dart';
import 'package:loantrack/data/local.dart';
import 'package:loantrack/helpers/colors.dart';
import 'package:loantrack/helpers/styles.dart';
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

  Notifications notifications = Notifications();

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
        body: Padding(
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
    );
  }

  loginHeader({
    required BuildContext context,
    String? message,
    String? title,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          'assets/images/icon.png',
          scale: 2,
        ),
        separatorSpace40,
        Text(
          (title != null) ? title : '',
          style: titleStyle(context),
        ),
        separatorSpace10,
        Text(
          (message != null) ? message : '',
          style: descriptionStyle(context),
          softWrap: true,
          textAlign: TextAlign.left,
        ),
        separatorSpace20,
      ],
    );
  }

  startLoginFlow(BuildContext context) {
    return Column(
      children: [
        loginHeader(context: context, message: LocalData.LoginInMessage),
        LoanTrackButton.primary(
          whenPressed: () {
            context.read<LoginState>().emailVerification();
          },
          context: context,
          label: 'Start',
        ),
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
    return Stack(children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          separatorSpace20,
          loginHeader(
            context: context,
            message: 'Like your expenses, tracking your loans will help you '
                'formulate better repayment strategies and check your future borrowings. \n\nEnter your email to begin.',
            title: 'Enter',
          ),
          separatorSpace50,
          LoanTrackTextField(
            controller: emailController,
            label: 'Email',
            color: LoanTrackColors.PrimaryOne,
            //icon: const Icon(Icons.email, color: LoanTrackColors.PrimaryOne),
          ),
          separatorSpace20,
          LoanTrackButton.primary(
            whenPressed: () {
              authService.checkEmailExists(
                context: context,
                email: emailController.text,
                errorCallback: (e) => showErrorDialog(
                  context: context,
                  title: 'Invalid Email',
                  errorMessage: 'This email is not valid. Kindly check '
                      'that you have typed a valid email.',
                ),
              );
              /*.whenComplete(
                    () => notifications.showNotification(
                      context: context,
                      title: 'Email Found',
                      body: 'We found your email.',
                    ),
                  );*/
            },
            context: context,
            label: 'Start Here',
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
          ),
        ],
      ),
      Positioned(
          bottom: 0,
          child: Row(
            children: [
              Icon(
                Icons.copyright,
                size: 20,
                color:
                    Theme.of(context).colorScheme.onBackground.withOpacity(.2),
              ),
              horizontalSeparatorSpace5,
              Image.asset(
                'assets/images/logo.png',
                scale: 15,
                color:
                    Theme.of(context).colorScheme.onBackground.withOpacity(.2),
              ),
              horizontalSeparatorSpace5,
              Text(
                DateTime.now().year.toString(),
                style: TextStyle(
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(.3),
                ),
              ),
            ],
          )),
    ]);
  }

  passwordRequest(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        separatorSpace20,
        loginHeader(
            context: context,
            title: 'Password',
            message: 'There is no shame in borrowing. '
                'Tracking your borrowings will keep '
                'them on top of your mind and in focus.'),
        separatorSpace40,
        LoanTrackTextField(
          controller: emailController,
          label: 'Email',
          color: LoanTrackColors.PrimaryOne,
          //icon: const Icon(Icons.email, color: LoanTrackColors.PrimaryOne),
        ),
        separatorSpace20,
        LoanTrackTextField(
          controller: passwordController,
          label: 'Password',
          isHidden: true,
          color: LoanTrackColors.PrimaryOne,
          //icon: const Icon(Icons.lock, color: LoanTrackColors.PrimaryOne),
        ),
        separatorSpace20,
        LoanTrackButton.primary(
          whenPressed: () {
            authService.signInWithEmailAndPassword(
              context: context,
              email: emailController.text,
              password: passwordController.text,
              errorCallback: (e) => showErrorDialog(
                  context: context,
                  title: 'Credential Error',
                  errorMessage:
                      'An error occurred. Verify that your password is correctly typed.'),
            );
            /*.whenComplete(
                  () => notifications.showNotification(
                      context: context,
                      title: 'Sign In Success',
                      body: 'You have successfully signed in.'),
                );*/
          },
          context: context,
          label: 'Log In',
        ),
        separatorSpace20,
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
              child: Text(
                'Forgot Password?',
                style: descriptionStyle(context),
              ),
            ),
            GestureDetector(
              onTap: () {
                context.read<LoginState>().emailVerification();
              },
              child: Text(
                'Cancel',
                style: descriptionStyle(context),
              ),
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 4.5,
        ),
        Row(
          children: [
            Icon(
              Icons.copyright,
              size: 20,
              color: Theme.of(context).colorScheme.onBackground.withOpacity(.2),
            ),
            horizontalSeparatorSpace5,
            Image.asset(
              'assets/images/logo.png',
              scale: 15,
              color: Theme.of(context).colorScheme.onBackground.withOpacity(.2),
            ),
            horizontalSeparatorSpace5,
            Text(
              DateTime.now().year.toString(),
              style: TextStyle(
                color:
                    Theme.of(context).colorScheme.onBackground.withOpacity(.3),
              ),
            ),
          ],
        ),
      ],
    );
  }

  createAccount(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        separatorSpace20,
        loginHeader(
            title: 'Create Account',
            context: context,
            message:
                'Start your journey now to a well-managed life. Whether it is living a loan-free life or just managing your loans properly, you\'ve come to the right place'),
        separatorSpace20,
        LoanTrackTextField(
          controller: emailController,
          label: 'Email',
          color: LoanTrackColors.PrimaryOne,
          // icon: const Icon(Icons.email, color: LoanTrackColors.PrimaryOne),
        ),
        separatorSpace20,
        LoanTrackTextField(
          controller: displayNameController,
          label: 'Username',
          color: LoanTrackColors.PrimaryOne,
          // icon: const Icon(Icons.person, color: LoanTrackColors.PrimaryOne),
        ),
        separatorSpace20,
        LoanTrackTextField(
          controller: passwordController,
          label: 'Password',
          isHidden: true,
          color: LoanTrackColors.PrimaryOne,
          //  icon: const Icon(Icons.lock, color: LoanTrackColors.PrimaryOne),
        ),
        separatorSpace20,
        LoanTrackButton.primary(
          whenPressed: () {
            authService
                .registerAccount(
                  context: context,
                  email: emailController.text,
                  displayName: displayNameController.text,
                  password: passwordController.text,
                  errorCallback: (e) => showErrorDialog(
                      context: context, title: 'Credential Error', e: e),
                )
                .whenComplete(
                  () => notifications.showNotification(
                      context: context,
                      title: 'Welcome ' + displayNameController.text,
                      body:
                          'Your Loantrack account has been successfully created. Welcome onboard.'),
                );
          },
          context: context,
          label: 'Create Account',
        ),
        separatorSpace20,
        LoanTrackButton.primaryOutline(
          whenPressed: () {
            context.read<LoginState>().emailVerification();
          },
          context: context,
          label: 'Cancel',
        ),
      ],
    );
  }

  sendingEmailVerificationScreen(BuildContext context) {
    return Column(
      children: [
        separatorSpace20,
        loginHeader(
          context: context,
          title: 'Email Verification',
          message: 'We will send you a verification link. '
              'Click \'Request Link\' to get the email now.',
        ),
        separatorSpace20,
        LoanTrackButton.primary(
          whenPressed: () async {
            try {
              await FirebaseAuth.instance.currentUser
                  ?.sendEmailVerification()
                  .whenComplete(
                    () => notifications.showNotification(
                      context: context,
                      title: 'Email Link Sent',
                      body: 'We have sent you a verification email. '
                          'Kindly check your email and follow the link.',
                    ),
                  );
              showSuccessDialog(
                  whenTapped: () {
                    Navigator.of(context).pop();
                    context.read<LoginState>().passwordCheck();
                  },
                  context: context,
                  title: 'Verification Sent',
                  successMessage: 'A verification link has been sent to you. '
                      'Kindly check your email and follow the instructions.');
            } on FirebaseAuthException catch (e) {
              showErrorDialog(context: context, title: 'Request Error', e: e);
            }
          },
          context: context,
          label: 'Request Link',
        ),
        separatorSpace20,
        GestureDetector(
          onTap: () {
            context.read<LoginState>().passwordCheck();
          },
          child: Text(
            'I have a link already and I\'ve confirmed my email',
            style: smallHeaderHighlightStyle(context),
          ),
        )
      ],
    );
  }
}
