import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loantrack/apps/credit_score_app.dart';
import 'package:loantrack/apps/loan_health_app.dart';
import 'package:loantrack/apps/loan_list_app.dart';
import 'package:loantrack/apps/news_app.dart';
import 'package:loantrack/apps/providers/loan_provider.dart';
import 'package:loantrack/apps/providers/preferences.dart';
import 'package:loantrack/apps/providers/theme_provider.dart';
import 'package:loantrack/apps/read_app.dart';
import 'package:loantrack/apps/summary.dart';
import 'package:loantrack/helpers/colors.dart';
import 'package:loantrack/helpers/styles.dart';
import 'package:loantrack/widgets/common_widgets.dart';
import 'package:provider/provider.dart';

import '../../helpers/listwidgets.dart';
import '../../widgets/application_grid_view.dart';
import '../../widgets/loan_track_modal.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ScrollController _controller = ScrollController();

  int storedThemeNumber = 0;

  void getTheme() async {
    ThemePreferences themePreferences = ThemePreferences();
    storedThemeNumber = await themePreferences.getTheme();
  }

  @override
  void initState() {
    getTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    String userId = FirebaseAuth.instance.currentUser!.uid;

    ScrollController sliderScrollController = ScrollController();

    // Watch theme

    var providedTheme = context.read<ThemeManager>().themeMode;

    return Stack(
      children: [
        SingleChildScrollView(
          controller: _controller,
          child: Container(
            padding: const EdgeInsets.only(left: 24, top: 16, right: 24),
            //height: MediaQuery.of(context).size.height,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const SizedBox(
                height: 250,
              ),
              // BEGIN LOAN CARD
              Container(
                width: screenWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    separatorSpace20,
                    Text(
                      'NEW RECORD',
                      style: sectionHeaderStyle(context),
                    ),
                    separatorSpace20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //BEGIN ACTION BUTTONS
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/loanRecord');
                          },
                          child: Container(
                            width: screenWidth / 2.4,
                            height: screenWidth / 2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(.05),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(
                                    left: 10.0,
                                    top: 10,
                                    right: 10,
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    size: 30,
                                  ),
                                ),
                                separatorSpace10,
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Text(
                                    'Add New Loan Record',
                                    style: featureTitleStyle(context),
                                  ),
                                ),
                                separatorSpace10,
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Text(
                                    'Keep track of your loans by recording them as soon as they are taken',
                                    style: smallerDescriptionStyle(context),
                                  ),
                                ),
                                separatorSpace10,
                                Container(
                                  width: double.infinity,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(.2),
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoanTrackingPage(
                                  isHome: false,
                                  loanListHeight: screenHeight * .73,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: screenWidth / 2.4,
                            height: screenWidth / 2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(.05),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 10.0,
                                    top: 10,
                                    right: 10,
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    size: 30,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                                separatorSpace10,
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Text(
                                    'Repayment Record',
                                    style: featureTitleStyle(context),
                                  ),
                                ),
                                separatorSpace5,
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Text(
                                    'Keeping track of your payments will help track your progress',
                                    style: smallerDescriptionStyle(context),
                                  ),
                                ),
                                separatorSpace10,
                                Container(
                                  width: double.infinity,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(.2),
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              separatorSpace20,

              //END ACTION BUTTONS

              // BEGIN LOAN PROGRESS

              // Progress header
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'TRACKING',
                      style: TextStyle(color: LoanTrackColors.PrimaryTwoLight),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoanTrackingPage(
                                      isHome: false,
                                      loanListHeight: screenHeight * .7,
                                    )));
                      },
                      child: const Text(
                        'SEE ALL',
                        style:
                            TextStyle(color: LoanTrackColors.PrimaryTwoLight),
                      ),
                    )
                  ],
                ),
              ),

              separatorSpace20,

              LoanSlider(
                  width: screenWidth,
                  height: screenHeight / 4.5,
                  userId: userId,
                  numberOfItems: 5),
              //END LOAN PROGRESS

              // BEGIN PRODUCT SLIDER

              //separatorSpace10,
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'POPULAR APPS',
                      style: TextStyle(color: LoanTrackColors.PrimaryTwoLight),
                    ),
                    GestureDetector(
                      onTap: () {
                        LoanTrackModal.modal(
                          context,
                          height: screenHeight / 2.3,
                          content: const LoanTrackAppsGridView(),
                          title: 'Applications',
                        );
                      },
                      child: const Text(
                        'SEE ALL',
                        style:
                            TextStyle(color: LoanTrackColors.PrimaryTwoLight),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight / 9,
                //padding: EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  //padding: EdgeInsets.only(right: 10),
                  controller: sliderScrollController,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Summary()));
                      },
                      child: LoanTrackProductLinkBox(
                        icon: Icon(Icons.calculate_outlined,
                            size: 30,
                            color: Theme.of(context).colorScheme.primary),
                        label: Text('SUMMARY',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 14),
                            softWrap: true),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    horizontalSeparatorSpace20,
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoanHealth()));
                      },
                      child: const LoanTrackProductLinkBox(
                        icon: Icon(Icons.health_and_safety,
                            size: 30, color: LoanTrackColors.PrimaryOneLight),
                        label: Text('HEALTH',
                            style: TextStyle(
                                color: LoanTrackColors.PrimaryOneLight,
                                fontSize: 14),
                            textAlign: TextAlign.center,
                            softWrap: true),
                        backgroundColor: LoanTrackColors.PrimaryOneVeryLight,
                      ),
                    ),
                    horizontalSeparatorSpace20,
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CreditScore()));
                      },
                      child: const LoanTrackProductLinkBox(
                        icon: Icon(Icons.numbers,
                            size: 30, color: LoanTrackColors2.PrimaryOne),
                        label: Text('SCORE',
                            style: TextStyle(
                                color: LoanTrackColors2.PrimaryOne,
                                fontSize: 14),
                            textAlign: TextAlign.center,
                            softWrap: true),
                        backgroundColor: LoanTrackColors2.PrimaryOne,
                      ),
                    ),
                    horizontalSeparatorSpace20,
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Read()));
                      },
                      child: LoanTrackProductLinkBox(
                        icon: Icon(Icons.book_outlined,
                            size: 30,
                            color: Theme.of(context).colorScheme.secondary),
                        label: Text('READ',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 14),
                            softWrap: true),
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    horizontalSeparatorSpace20,
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => NewsApp()));
                      },
                      child: const LoanTrackProductLinkBox(
                        icon: Icon(Icons.newspaper,
                            size: 30, color: LoanTrackColors2.TetiaryOne),
                        label: Text('NEWS',
                            style: TextStyle(
                                color: LoanTrackColors2.TetiaryOne,
                                fontSize: 14),
                            textAlign: TextAlign.center,
                            softWrap: true),
                        backgroundColor: LoanTrackColors2.TetiaryOne,
                      ),
                    ),
                  ],
                ),
              ),
              //END PRODUCT SLIDER
              separatorSpace20,
            ]),
          ),
        ),

        // Top Fixed Card
        Container(
          color: Theme.of(context).colorScheme.background,
          height: screenHeight / 3.3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                separatorSpace10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.zero,
                          width: screenWidth / 12,
                          height: screenWidth / 12,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: .5,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onBackground
                                  .withOpacity(.5),
                            ),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Image.asset(
                            'assets/images/user_profile.png',
                            scale: 10,
                            color: Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(.5),
                          ),
                        ),
                        horizontalSeparatorSpace10,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Welcome, ',
                                    style: sectionHeaderStyle(context)),
                                separatorSpace5,
                                Text(
                                    FirebaseAuth
                                        .instance.currentUser!.displayName
                                        .toString(),
                                    //.toUpperCase(),
                                    style: sectionHeaderStyle(context)),
                              ],
                            ),
                            // separatorSpace5,
                            Text(
                                Timestamp.now()
                                    .toDate()
                                    .toLocal()
                                    .toString()
                                    .substring(0, 16),
                                style: smallerDescriptionStyle(context)),
                          ],
                        ),
                      ],
                    ),
                    (storedThemeNumber == 1 || providedTheme == ThemeMode.light)
                        ? const Icon(
                            Icons.light_mode,
                            size: 20,
                          )
                        : (storedThemeNumber == 2 ||
                                providedTheme == ThemeMode.dark)
                            ? const Icon(Icons.nightlight)
                            : const Icon(Icons.contrast),
                  ],
                ),
                separatorSpace40,

                Text(
                  'CURRENT LOAN TOTAL',
                  style: sectionHeaderStyle(context),
                ),
                separatorSpace5,
                // LOAN TOTAL STREAM

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(builder: (context) => const Summary()),
                    );
                  },
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('loans')
                          .where('userId', isEqualTo: userId)
                          .snapshots(),
                      builder: (context, snapshot) {
                        double totalLoans = 0;
                        double totalRepaid = 0;
                        int numberOfLenders = 0;
                        int len = 0;
                        if (snapshot.data?.docs.length != null) {
                          len = snapshot.data!.docs.length;
                        } else {
                          len = 0;
                        }

                        for (int i = 0; i < len; i++) {
                          DocumentSnapshot documentSnapshot =
                              snapshot.data!.docs[i];

                          totalRepaid += documentSnapshot.get('amountRepaid');

                          numberOfLenders += 1;

                          DateTime dueWhen = DateTime.parse(
                              documentSnapshot.get('dueWhen').toString());
                          Duration duration =
                              DateTime.now().difference(dueWhen);
                          int due = duration.inDays;

                          if (due <= 0) {
                            totalLoans += (documentSnapshot.get('loanAmount') -
                                documentSnapshot.get('amountRepaid'));
                          } else {
                            totalLoans += ((documentSnapshot.get('loanAmount') -
                                    documentSnapshot.get('amountRepaid')) +
                                (documentSnapshot.get('dailyOverdueCharge') *
                                    due));
                          }
                        }

                        // Provide Total Loans
                        context
                            .read<LoanDetailsProviders>()
                            .setLoanTotal(totalLoans);

                        // Provide Total Repaid
                        context
                            .read<LoanDetailsProviders>()
                            .setRepaidTotal(totalRepaid);

                        // Provide number of lenders
                        context
                            .read<LoanDetailsProviders>()
                            .setNumberOfLenders(numberOfLenders);

                        return (totalLoans > 0)
                            ? Text(
                                totalLoans.toString(),
                                style: titleStyle(context),
                              )
                            : Text(
                                '0.0',
                                style: titleStyle(context),
                              );
                      }),
                ),
                separatorSpace20,
                Text(
                  'TOP LENDERS',
                  style: sectionHeaderStyle(context),
                ),
                separatorSpace10,
                LoanBulletedList(height: 25, numberOfItems: 5, userId: userId),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class LoanTrackProductLinkBox extends StatelessWidget {
  const LoanTrackProductLinkBox({
    Key? key,
    required this.icon,
    required this.label,
    required this.backgroundColor,
    this.whenTapped,
  }) : super(key: key);

  final Icon icon;
  final Widget label;
  final Function()? whenTapped;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: whenTapped,
      borderRadius: BorderRadius.circular(10),
      //focusColor: LoanTrackColors2.PrimaryOneVeryLight,
      child: Container(
        width: screenWidth / 3.5,
        height: screenWidth / 3.5,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: backgroundColor.withOpacity(.1),
            borderRadius: BorderRadius.circular(10),
            border:
                Border.all(color: backgroundColor.withOpacity(.3), width: .5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                icon,
                separatorSpace10,
                label,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
