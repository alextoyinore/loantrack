import 'package:flutter/material.dart';
import 'package:loantrack/apps/providers/login_states.dart';
import 'package:loantrack/apps/providers/preferences.dart';
import 'package:loantrack/apps/providers/theme_provider.dart';
import 'package:loantrack/apps/widgets/updateprofile.dart';
import 'package:loantrack/data/applists.dart';
import 'package:loantrack/data/authentications.dart';
import 'package:loantrack/helpers/colors.dart';
import 'package:loantrack/helpers/styles.dart';
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
  int storedThemeNumber = 0;

  Future<void> getThemeNumber() async {
    AppPreferences themePreferences = AppPreferences();
    int themeNumber = await themePreferences.getThemeNumber();
    setState(() {
      storedThemeNumber = themeNumber;
    });
  }

  @override
  void initState() {
    getThemeNumber();
    super.initState();
  }

  String themeName = '';

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    // Watch theme
    context.watch<ThemeManager>().themeNumber;
    var newlySetTheme = context.read<ThemeManager>().themeNumber;

    if (newlySetTheme > -1) {
      setState(() {
        storedThemeNumber = newlySetTheme;
      });
    }

    if (storedThemeNumber == 1) {
      themeName = 'Light';
    } else if (storedThemeNumber == 2) {
      themeName = 'Dark';
    } else {
      themeName = 'System';
    }

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SingleChildScrollView(
        child: Container(
          width: screenWidth,
          padding: const EdgeInsets.only(left: 16.0, right: 16, top: 24),
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Settings',
                style: titleStyle(context),
              ),
              separatorSpace20,
              Text(
                'Adjust your app settings here. Manage your profile settings, app look and feel, and other settings.',
                style: descriptionStyle(context),
              ),
              separatorSpace40,
              GestureDetector(
                onTap: () {
                  LoanTrackModal.modal(context,
                      height: MediaQuery.of(context).size.height / 2,
                      content: SingleChildScrollView(
                          child: Text(LocalData.aboutLoanTrack,
                              style: TextStyle(
                                  fontSize: 18,
                                  height: 1.5,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground
                                      .withOpacity(.5)),
                              softWrap: true)),
                      title: 'About');
                },
                child: Row(children: [
                  const Icon(
                    Icons.info_outline,
                    size: 30,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    'About',
                    style: bodyStyle(context),
                  ),
                ]),
              ),
              separatorSpace40,
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileUpdate(),
                      ));
                },
                child: Row(children: [
                  const Icon(
                    Icons.person,
                    size: 30,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Profile Settings',
                    style: bodyStyle(context),
                  ),
                ]),
              ),
              separatorSpace40,
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
                                      context.read<ThemeManager>().setTheme(1);
                                    } else if (AppLists.theme[index] ==
                                        'Dark') {
                                      context.read<ThemeManager>().setTheme(2);
                                    } else {
                                      context.read<ThemeManager>().setTheme(0);
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
                child: Row(children: [
                  const Icon(
                    Icons.light,
                    size: 30,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: screenWidth / 1.3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Theme',
                          style: bodyStyle(context),
                        ),
                        Text(
                          themeName,
                          style: bodyStyle(context),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
              separatorSpace40,
              GestureDetector(
                onTap: () {
                  AuthService auth = AuthService();
                  auth.signOut();
                  context.read<LoginState>().emailVerification();
                  Navigator.pushNamed(context, '/login');
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: Theme.of(context).colorScheme.tertiary,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Sign Out',
                      style: bodyStyle(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
