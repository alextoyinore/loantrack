import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loantrack/apps/widgets/button.dart';
import 'package:loantrack/helpers/colors.dart';
import 'package:loantrack/helpers/common_widgets.dart';
import 'package:loantrack/widgets/loan_track_textfield.dart';

class ProfileUpdate extends StatefulWidget {
  const ProfileUpdate({Key? key}) : super(key: key);

  @override
  State<ProfileUpdate> createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: LoanTrackColors.PrimaryOne,
        backgroundColor: Colors.white, //LoanTrackColors.PrimaryOne,
        elevation: 0,
        title: const Text(
          'Edit Your Profile',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            separatorSpace20,
            LoanTrackTextField(
              label: 'First Name',
              color: LoanTrackColors.PrimaryTwoVeryLight,
            ),
            separatorSpace10,
            LoanTrackTextField(
              label: 'Last Name',
              color: LoanTrackColors.PrimaryTwoVeryLight,
            ),
            separatorSpace10,
            LoanTrackTextField(
              label: 'Age',
              color: LoanTrackColors.PrimaryTwoVeryLight,
            ),
            separatorSpace10,
            LoanTrackTextField(
              label: 'Total Monthly Income',
              color: LoanTrackColors.PrimaryTwoVeryLight,
            ),
            separatorSpace10,
            LoanTrackTextField(
              label: 'Occupation',
              color: LoanTrackColors.PrimaryTwoVeryLight,
            ),
            separatorSpace10,
            LoanTrackTextField(
              label: 'Country of Residence',
              color: LoanTrackColors.PrimaryTwoVeryLight,
            ),
            separatorSpace10,
            LoanTrackTextField(
              label: 'City of Residence',
              color: LoanTrackColors.PrimaryTwoVeryLight,
            ),
            separatorSpace10,
            LoanTrackTextField(
              label: 'Nationality',
              color: LoanTrackColors.PrimaryTwoVeryLight,
            ),
            separatorSpace10,
            ToggleButtons(children: const [
              Text('Gender'),
              Text('Married'),
            ], isSelected: [
              true,
              true
            ]),
            separatorSpace10,
            LoanTrackButton.primary(context: context, label: 'Continue')
          ],
        ),
      ),
    );
  }
}
