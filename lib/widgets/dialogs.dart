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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Theme.of(context).colorScheme.errorContainer,
        buttonPadding: EdgeInsets.zero,
        title: Text(
          title,
          style: TextStyle(
            fontSize: 24,
            color: Theme.of(context).colorScheme.onErrorContainer,
          ),
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
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onErrorContainer,
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(24),
            child: LoanTrackButton.error(
              whenPressed: () {
                Navigator.of(context).pop();
              },
              context: context,
              label: 'Cancel',
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
    required VoidCallback whenTapped}) {
  showDialog<void>(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: LoanTrackColors2.TetiaryOne,
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
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(24),
            child: LoanTrackButton.primaryOutline(
              whenPressed: whenTapped,
              context: context,
              label: 'Continue',
            ),
          ),
        ],
      );
    },
  );
}
