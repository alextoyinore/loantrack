import 'package:flutter/material.dart';
import 'package:loantrack/apps/providers/login_states.dart';
import 'package:loantrack/apps/providers/theme_provider.dart';
import 'package:loantrack/apps/widgets/updateprofile.dart';
import 'package:loantrack/data/applists.dart';
import 'package:loantrack/data/authentications.dart';
import 'package:loantrack/helpers/colors.dart';
import 'package:loantrack/widgets/common_widgets.dart';
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String themeName = context.read<ThemeManager>().themeName();
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
                leading: const Icon(
                  Icons.info_outline,
                ),
                title: const Text(
                  'About',
                  style: TextStyle(
                    color: LoanTrackColors.PrimaryTwoLight,
                  ),
                ),
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
                leading: const Icon(
                  Icons.person,
                ),
                title: const Text(
                  'Profile Settings',
                  style: TextStyle(
                    color: LoanTrackColors.PrimaryTwoLight,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileUpdate(),
                      ));
                },
              ),
              Divider(
                  thickness: .5,
                  color: LoanTrackColors.PrimaryTwo.withOpacity(.2)),
              GestureDetector(
                onTap: () => LoanTrackModal.modal(
                  context,
                  height: MediaQuery.of(context).size.height / 3.5,
                  content: Column(
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: List.generate(
                          AppLists.theme.length,
                          (index) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    themeName = AppLists.theme[index];
                                    if (AppLists.theme[index] == 'Light') {
                                      context
                                          .read<ThemeManager>()
                                          .setLightTheme();
                                    } else if (AppLists.theme[index] ==
                                        'Dark') {
                                      context
                                          .read<ThemeManager>()
                                          .setDarkTheme();
                                    } else {
                                      context
                                          .read<ThemeManager>()
                                          .setSystemTheme();
                                    }

                                    Navigator.pop(context);
                                  });
                                },
                                child: ListTile(
                                  title: Text(
                                    AppLists.theme[index],
                                    style: const TextStyle(
                                      color:
                                          LoanTrackColors.PrimaryTwoVeryLight,
                                    ),
                                  ),
                                ),
                              ))),
                  title: 'Select Theme',
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.light,
                  ),
                  title: const Text(
                    'Theme',
                    style: TextStyle(
                      color: LoanTrackColors.PrimaryTwoLight,
                    ),
                  ),
                  trailing: Text(
                    themeName,
                    style: const TextStyle(
                      color: seed,
                    ),
                  ),
                ),
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
                  Navigator.pushNamed(context, '/login');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
