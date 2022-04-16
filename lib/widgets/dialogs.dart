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
            child: LoanTrackButton.secondary(
                context: context,
                label: 'Cancel',
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(4),
                    bottomLeft: Radius.circular(4))),
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
                '${successMessage}',
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
            child: LoanTrackButton.primary(
              context: context,
              label: 'Ok',
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(4),
                  bottomRight: Radius.circular(4)),
            ),
          ),
        ],
      );
    },
  );
}
