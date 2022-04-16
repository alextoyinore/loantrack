import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loantrack/apps/providers/login_states.dart';
import 'package:loantrack/apps/widgets/button.dart';
import 'package:loantrack/data/authentications.dart';
import 'package:loantrack/data/local.dart';
import 'package:loantrack/helpers/colors.dart';
import 'package:loantrack/widgets/dialogs.dart';
import 'package:loantrack/widgets/loan_track_modal.dart';
import 'package:loantrack/widgets/loan_track_textfield.dart';
import 'package:provider/provider.dart';

class LoanTackLogin extends StatefulWidget {
  const LoanTackLogin({Key? key}) : super(key: key);

  @override
  State<LoanTackLogin> createState() => _LoanTackLoginState();
}

class _LoanTackLoginState extends State<LoanTackLogin> with ChangeNotifier {
  //Controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController displayNameController = TextEditingController();
  //FirebaseAuthException e = FirebaseAuthException(code: 'network-not-found');

  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    States loginState = context.watch<LoginState>().loginState;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        /* appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Image.asset('assets/images/loantrack.png', height: 18),
          ),
          //centerTitle: true,
          actions: [
            Padding(
                padding: EdgeInsets.only(right: 32),
                child: GestureDetector(
                    onTap: () {
                      LoanTrackModal.modal(context,
                          content: const SingleChildScrollView(
                            child: Text(LocalData.aboutLoanTrack,
                                style: TextStyle(
                                    color: LoanTrackColors.PrimaryTwoLight,
                                    fontSize: 16,
                                    height: 1.6)),
                          ),
                          title: 'About');
                    },
                    child: const Icon(
                      Icons.info_outline,
                      color: LoanTrackColors.PrimaryTwoLight,
                    )))
          ],
        ),*/
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: SingleChildScrollView(
            child: (loginState == States.loggedOut)
                ? startLoginFlow(context)
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

  loginHeader({required BuildContext context, String? message}) {
    return Column(
      children: [
        SizedBox(height: 80),
        Image.asset('assets/images/icon.png', scale: 50),
        SizedBox(height: 50),
        Text(
          (message != null) ? message : '',
          style: TextStyle(color: LoanTrackColors.PrimaryTwoVeryLight),
          softWrap: true,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
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
                borderRadius: BorderRadius.circular(10))),
        SizedBox(height: 50),
        GestureDetector(
            onTap: () {
              LoanTrackModal.modal(context,
                  content: const SingleChildScrollView(
                    child: Text(LocalData.aboutLoanTrack,
                        style: TextStyle(
                            color: LoanTrackColors.PrimaryTwoLight,
                            fontSize: 14,
                            height: 1.6)),
                  ),
                  title: 'About');
            },
            child: Text(
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
                'Like our expenditures and investments, your loans tracked will give you peace of mind and help you live a more fulfilling life.'),
        LoanTrackTextField(
          controller: emailController,
          label: 'Email',
          color: LoanTrackColors.PrimaryOne,
          icon: Icon(Icons.email, color: LoanTrackColors.PrimaryOne),
        ),
        SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            authService.checkEmailExists(
              context: context,
              email: emailController.text,
              errorCallback: (e) => showErrorDialog(
                context: context,
                title: 'Invalid Email',
                e: e,
              ),
            );
          },
          child: LoanTrackButton.primary(
            context: context,
            label: 'Login',
            borderRadius: BorderRadius.circular(10),
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
          icon: Icon(Icons.email, color: LoanTrackColors.PrimaryOne),
        ),
        const SizedBox(height: 10),
        LoanTrackTextField(
          controller: passwordController,
          label: 'Password',
          isHidden: true,
          color: LoanTrackColors.PrimaryOne,
          icon: Icon(Icons.lock, color: LoanTrackColors.PrimaryOne),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () async {
            authService.signInWithEmailAndPassword(
                context: context,
                email: emailController.text,
                password: passwordController.text,
                errorCallback: (e) => showErrorDialog(
                    context: context, title: 'Credential Error', e: e));

            //Navigator.pushNamed(context, '/home');
          },
          child: LoanTrackButton.primary(
            context: context,
            label: 'Log In',
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(height: 10),
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
                style: TextStyle(color: LoanTrackColors.PrimaryTwoLight),
              ),
            ),
            GestureDetector(
              onTap: () {
                context.read<LoginState>().emailVerification();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: LoanTrackColors.PrimaryTwoLight),
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
          icon: Icon(Icons.email, color: LoanTrackColors.PrimaryOne),
        ),
        SizedBox(height: 10),
        LoanTrackTextField(
          controller: displayNameController,
          label: 'Display Name',
          color: LoanTrackColors.PrimaryOne,
          icon: Icon(Icons.person, color: LoanTrackColors.PrimaryOne),
        ),
        SizedBox(height: 10),
        LoanTrackTextField(
          controller: passwordController,
          label: 'Password',
          isHidden: true,
          color: LoanTrackColors.PrimaryOne,
          icon: Icon(Icons.lock, color: LoanTrackColors.PrimaryOne),
        ),
        SizedBox(height: 10),
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
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            context.read<LoginState>().emailVerification();
          },
          child: LoanTrackButton.secondaryOutline(
            context: context,
            label: 'Cancel',
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }

  sendingEmailVerificationScreen(BuildContext context) {
    return Column(
      children: [
        loginHeader(context: context),
        SizedBox(height: 20),
        const Text(
          'We will send you a verification link. Click \'Request Link\' to get the email now.',
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
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
              borderRadius: BorderRadius.circular(10),
            )),
        SizedBox(height: 20),
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
