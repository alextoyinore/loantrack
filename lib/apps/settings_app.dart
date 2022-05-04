import 'package:flutter/material.dart';
import 'package:loantrack/apps/providers/login_states.dart';
import 'package:loantrack/data/authentications.dart';
import 'package:loantrack/helpers/colors.dart';
import 'package:loantrack/helpers/common_widgets.dart';
import 'package:provider/provider.dart';

import '../data/local.dart';
import '../widgets/loan_track_modal.dart';

class AppSettings extends StatefulWidget {
  const AppSettings({Key? key}) : super(key: key);

  @override
  State<AppSettings> createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 16.0, right: 16, top: 32),
          height: MediaQuery.of(context).size.height,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 16.0, right: 16),
                child: const Text(
                  'Adjust your app settings here. Manage your profile settings, app look and feel, and other settings.',
                  style: TextStyle(color: LoanTrackColors.PrimaryTwoVeryLight),
                ),
              ),
              separatorSpace10,
              ListTile(
                leading: const Icon(Icons.info_outline,
                    color: LoanTrackColors.PrimaryOne),
                title: const Text('About',
                    style: TextStyle(color: LoanTrackColors.PrimaryOne)),
                onTap: () {
                  LoanTrackModal.modal(context,
                      content: const SingleChildScrollView(
                          child: Text(LocalData.aboutLoanTrack,
                              style: TextStyle(
                                  //fontSize: 14,
                                  height: 1.5,
                                  color: LoanTrackColors.PrimaryTwoLight),
                              softWrap: true)),
                      title: 'About');
                },
              ),
              Divider(
                  thickness: .5,
                  color: LoanTrackColors.PrimaryTwo.withOpacity(.2)),
              ListTile(
                leading:
                    const Icon(Icons.person, color: LoanTrackColors.PrimaryOne),
                title: const Text('Profile Settings',
                    style: TextStyle(color: LoanTrackColors.PrimaryOne)),
                onTap: () {},
              ),
              Divider(
                  thickness: .5,
                  color: LoanTrackColors.PrimaryTwo.withOpacity(.2)),
              ListTile(
                leading: const Icon(Icons.logout,
                    color: LoanTrackColors2.PrimaryOneLight),
                title: const Text('Sign Out',
                    style: TextStyle(color: LoanTrackColors2.PrimaryOneLight)),
                onTap: () {
                  AuthService auth = AuthService();
                  auth.signOut();
                  context.read<LoginState>().emailVerification();
                  Navigator.pushNamed(context, '/');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
