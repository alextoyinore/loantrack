import 'package:flutter/material.dart';
import 'package:loantrack/apps/widgets/button.dart';
import 'package:loantrack/helpers/colors.dart';

void showErrorDialog(
    {required BuildContext context,
    required String title,
    Exception? e,
    String? errorMessage}) {
  showDialog<void>(
    context: context,
    builder: (context) {
      return AlertDialog(
        buttonPadding: EdgeInsets.zero,
        title: Text(
          title,
          style: const TextStyle(fontSize: 24),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                (errorMessage == '' || errorMessage == null)
                    ? '${(e as dynamic).message}'
                    : errorMessage,
                textAlign: TextAlign.left,
                style: const TextStyle(
                    fontSize: 16, color: LoanTrackColors.PrimaryTwoLight),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: LoanTrackButton.secondary(
                context: context,
                label: 'Cancel',
              ),
            ),
          ),
        ],
      );
    },
  );
}

void showSuccessDialog(
    {required BuildContext context,
    required String title,
    required String successMessage,
    Function()? whenTapped}) {
  showDialog<void>(
    context: context,
    builder: (context) {
      return AlertDialog(
        buttonPadding: EdgeInsets.zero,
        title: Text(
          title,
          style: const TextStyle(fontSize: 24),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                successMessage,
                textAlign: TextAlign.left,
                style: const TextStyle(
                    fontSize: 16, color: LoanTrackColors.PrimaryTwoLight),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: whenTapped,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: LoanTrackButton.primary(
                context: context,
                label: 'Continue',
              ),
            ),
          ),
        ],
      );
    },
  );
}
