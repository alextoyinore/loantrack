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

  @override
  Widget build(BuildContext context) {
    States loginState = context.watch<LoginState>().loginState;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
      ),
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
    );
  }

  startLoginFlow(BuildContext context) {
    return Column(
      children: [
        Text(LocalData.LoginInMessage),
        GestureDetector(
            onTap: () {
              context.read<LoginState>().emailVerification();
            },
            child: LoanTrackButton.primary(context: context, label: 'Start'))
      ],
    );
  }

  emailVerifier(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: emailController,
          style: TextStyle(color: LoanTrackColors.PrimaryTwoLight),
          decoration: const InputDecoration(
            hintText: 'Email',
            suffixIcon: Icon(Icons.email),
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            checkEmailExists(
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
        TextField(
          controller: emailController,
          style: const TextStyle(color: LoanTrackColors.PrimaryTwoLight),
          decoration: const InputDecoration(
            hintText: 'Email',
            suffixIcon: Icon(Icons.email),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: passwordController,
          obscureText: true,
          style: const TextStyle(color: LoanTrackColors.PrimaryTwoLight),
          decoration: const InputDecoration(
            hintText: 'Password',
            suffixIcon: Icon(Icons.lock),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () async {
            signInWithEmailAndPassword(
                context: context,
                email: emailController.text,
                password: passwordController.text,
                errorCallback: (e) => showErrorDialog(
                    context: context, title: 'Credential Error', e: e));

            //Navigator.pushNamed(context, '/home');
          },
          child: LoanTrackButton.primary(context: context, label: 'Log In'),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                forgotPassword(
                    context: context,
                    email: emailController.text,
                    errorCallback: (e) => showErrorDialog(
                          context: context,
                          title: 'Credential Error',
                          e: e,
                        )).whenComplete(() => showSuccessDialog(
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
        TextField(
          controller: emailController,
          style: TextStyle(color: LoanTrackColors.PrimaryTwoLight),
          decoration: const InputDecoration(
            hintText: 'Email',
            suffixIcon: Icon(Icons.email),
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: displayNameController,
          style: TextStyle(color: LoanTrackColors.PrimaryTwoLight),
          decoration: const InputDecoration(
            hintText: 'Display Name',
            suffixIcon: Icon(Icons.email),
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: passwordController,
          obscureText: true,
          style: TextStyle(color: LoanTrackColors.PrimaryTwoLight),
          decoration: const InputDecoration(
            hintText: 'Password',
            suffixIcon: Icon(Icons.lock),
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            registerAccount(
                context: context,
                email: emailController.text,
                displayName: displayNameController.text,
                password: passwordController.text,
                errorCallback: (e) => showErrorDialog(
                    context: context, title: 'Credential Error', e: e));
          },
          child: LoanTrackButton.primary(
              context: context, label: 'Create Account'),
        ),
        SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            registerAccount(
                context: context,
                email: emailController.text,
                displayName: displayNameController.text,
                password: passwordController.text,
                errorCallback: (e) => showErrorDialog(
                    context: context, title: 'Credential Error', e: e));
          },
          child: LoanTrackButton.secondaryOutline(
              context: context, label: 'Cancel'),
        ),
      ],
    );
  }

  sendingEmailVerificationScreen(BuildContext context) {
    return Column(
      children: [
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
                context: context, label: 'Request Link')),
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
