import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loantrack/apps/messages/notifications.dart';
import 'package:loantrack/apps/providers/preferences.dart';
import 'package:loantrack/apps/widgets/button.dart';
import 'package:loantrack/data/applists.dart';
import 'package:loantrack/data/database.dart';
import 'package:loantrack/helpers/colors.dart';
import 'package:loantrack/helpers/styles.dart';
import 'package:loantrack/widgets/common_widgets.dart';
import 'package:loantrack/widgets/dialogs.dart';
import 'package:loantrack/widgets/loan_track_modal.dart';
import 'package:loantrack/widgets/loan_track_textfield.dart';
import 'package:provider/provider.dart';

import '../providers/loan_provider.dart';

class ProfileUpdate extends StatefulWidget {
  const ProfileUpdate({Key? key}) : super(key: key);

  @override
  State<ProfileUpdate> createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  //Controllers
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController maritalStatusController = TextEditingController();
  TextEditingController totalMonthlyIncomeController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController occupationIndustryController = TextEditingController();
  TextEditingController countryOfResidenceController = TextEditingController();
  TextEditingController cityOfResidenceController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController samaritanController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    double netIncome = context.read<LoanDetailsProviders>().netIncome;
    print(netIncome);

    AppPreferences preferences = AppPreferences();

    return Scaffold(
      body: (netIncome == 0)
          ? Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 300,
                      ),
                      Text(
                        'BIO',
                        style: smallTitleStyle(context),
                      ),

                      separatorSpace20,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LoanTrackTextField(
                            controller: firstnameController,
                            label: 'First Name',
                            color: LoanTrackColors.PrimaryTwoVeryLight,
                          ),
                          separatorSpace5,
                          const Text(
                            'Your first name is the name you are addressed by.',
                            style: TextStyle(
                              color: LoanTrackColors.PrimaryTwoVeryLight,
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                      separatorSpace10,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LoanTrackTextField(
                            controller: lastnameController,
                            label: 'Last Name',
                            color: LoanTrackColors.PrimaryTwoVeryLight,
                          ),
                          separatorSpace5,
                          const Text(
                            'Your last name is your family name.',
                            style: TextStyle(
                              color: LoanTrackColors.PrimaryTwoVeryLight,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      separatorSpace10,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LoanTrackTextField(
                            keyboardType:
                                const TextInputType.numberWithOptions(),
                            controller: ageController,
                            label: 'Age',
                            color: LoanTrackColors.PrimaryTwoVeryLight,
                          ),
                          separatorSpace5,
                          const Text(
                            'We advice that persons under the age of 18 refrain from taking loans of any kind.',
                            style: TextStyle(
                              color: LoanTrackColors.PrimaryTwoVeryLight,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      separatorSpace10,
                      //Gender
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () => LoanTrackModal.modal(
                              context,
                              height: screenHeight / 3.5,
                              content: Column(
                                  //crossAxisAlignment: CrossAxisAlignment.center,
                                  children: List.generate(
                                      AppLists.genders.length,
                                      (index) => GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                genderController.text =
                                                    AppLists.genders[index];
                                                Navigator.pop(context);
                                              });
                                            },
                                            child: ListTile(
                                              title: Text(
                                                AppLists.genders[index],
                                                style: const TextStyle(
                                                  color: LoanTrackColors
                                                      .PrimaryTwoVeryLight,
                                                ),
                                              ),
                                            ),
                                          ))),
                              title: 'Gender',
                            ),
                            child: LoanTrackTextField(
                              controller: genderController,
                              enable: false,
                              label: 'Gender',
                              color: LoanTrackColors.PrimaryTwoVeryLight,
                            ),
                          ),
                          separatorSpace5,
                          const Text(
                            'What gender affiliation do you identity with?',
                            style: TextStyle(
                              color: LoanTrackColors.PrimaryTwoVeryLight,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      separatorSpace10,

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () => LoanTrackModal.modal(
                              context,
                              height: screenHeight / 3,
                              content: Column(
                                  //crossAxisAlignment: CrossAxisAlignment.center,
                                  children: List.generate(
                                      AppLists.maritalStatus.length,
                                      (index) => GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                maritalStatusController.text =
                                                    AppLists
                                                        .maritalStatus[index];

                                                Navigator.pop(context);
                                              });
                                            },
                                            child: ListTile(
                                              title: Text(
                                                AppLists.maritalStatus[index],
                                                style: const TextStyle(
                                                  color: LoanTrackColors
                                                      .PrimaryTwoVeryLight,
                                                ),
                                              ),
                                            ),
                                          ))),
                              title: 'Marital Status',
                            ),
                            child: LoanTrackTextField(
                              controller: maritalStatusController,
                              enable: false,
                              label: 'Marital Status',
                              color: LoanTrackColors.PrimaryTwoVeryLight,
                            ),
                          ),
                          separatorSpace5,
                          const Text(
                            'Knowing your marital status will help us better serve you by sending you information and recommendations tailored to your need.',
                            style: TextStyle(
                              color: LoanTrackColors.PrimaryTwoVeryLight,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),

                      separatorSpace80,

                      Text(
                        'FINANCIALS',
                        style: smallTitleStyle(context),
                      ),
                      separatorSpace10,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LoanTrackTextField(
                            keyboardType:
                                const TextInputType.numberWithOptions(),
                            controller: totalMonthlyIncomeController,
                            label: 'Total Monthly Income',
                            color: LoanTrackColors.PrimaryTwoVeryLight,
                          ),
                          separatorSpace5,
                          const Text(
                            'It is advisable to keep your borrowings under 50% of your total income',
                            style: TextStyle(
                              color: LoanTrackColors.PrimaryTwoVeryLight,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      separatorSpace20,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LoanTrackTextField(
                            controller: occupationController,
                            label: 'Occupation',
                            color: LoanTrackColors.PrimaryTwoVeryLight,
                          ),
                          separatorSpace5,
                          const Text(
                            'Tell us what best describes what you do whether you are in corporate sector or self-employed.',
                            style: TextStyle(
                              color: LoanTrackColors.PrimaryTwoVeryLight,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      separatorSpace20,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () => LoanTrackModal.modal(
                              context,
                              height: screenHeight / 2,
                              content: Column(
                                  //crossAxisAlignment: CrossAxisAlignment.center,
                                  children: List.generate(
                                      AppLists.occupationIndustry.length,
                                      (index) => GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                occupationIndustryController
                                                        .text =
                                                    AppLists.occupationIndustry[
                                                        index];
                                                Navigator.pop(context);
                                              });
                                            },
                                            child: ListTile(
                                              title: Text(
                                                AppLists
                                                    .occupationIndustry[index],
                                                style: const TextStyle(
                                                  color: LoanTrackColors
                                                      .PrimaryTwoVeryLight,
                                                ),
                                              ),
                                            ),
                                          ))),
                              title: 'Industry',
                            ),
                            child: LoanTrackTextField(
                              enable: false,
                              controller: occupationIndustryController,
                              label: 'Industry',
                              color: LoanTrackColors.PrimaryTwoVeryLight,
                            ),
                          ),
                          separatorSpace5,
                          const Text(
                            'Select the Industry in which your occupation fits. We are constantly updating this list to be as encompassing as possible.',
                            style: TextStyle(
                              color: LoanTrackColors.PrimaryTwoVeryLight,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),

                      separatorSpace80,
                      Text(
                        'LOCATION',
                        style: smallTitleStyle(context),
                      ),
                      separatorSpace20,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () => LoanTrackModal.modal(
                              context,
                              height: screenHeight / 3,
                              content: Column(
                                  //crossAxisAlignment: CrossAxisAlignment.center,
                                  children: List.generate(
                                      AppLists.countries.length,
                                      (index) => GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                countryOfResidenceController
                                                        .text =
                                                    AppLists.countries[index];
                                                Navigator.pop(context);
                                              });
                                            },
                                            child: ListTile(
                                              title: Text(
                                                AppLists.countries[index],
                                                style: const TextStyle(
                                                  color: LoanTrackColors
                                                      .PrimaryTwoVeryLight,
                                                ),
                                              ),
                                            ),
                                          ))),
                              title: 'Country of Residence',
                            ),
                            child: LoanTrackTextField(
                              enable: false,
                              controller: countryOfResidenceController,
                              label: 'Country of Residence',
                              color: LoanTrackColors.PrimaryTwoVeryLight,
                            ),
                          ),
                          separatorSpace5,
                          const Text(
                            'Tell us the country you are currently living in.',
                            style: TextStyle(
                              color: LoanTrackColors.PrimaryTwoVeryLight,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      separatorSpace20,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () => LoanTrackModal.modal(
                              context,
                              height: screenHeight / 3,
                              content: Column(
                                  //crossAxisAlignment: CrossAxisAlignment.center,
                                  children: List.generate(
                                      AppLists.cities.length,
                                      (index) => GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                cityOfResidenceController.text =
                                                    AppLists.cities[index];
                                                Navigator.pop(context);
                                              });
                                            },
                                            child: ListTile(
                                              title: Text(
                                                AppLists.cities[index],
                                                style: const TextStyle(
                                                  color: LoanTrackColors
                                                      .PrimaryTwoVeryLight,
                                                ),
                                              ),
                                            ),
                                          ))),
                              title: 'City of Residence',
                            ),
                            child: LoanTrackTextField(
                              enable: false,
                              controller: cityOfResidenceController,
                              label: 'City of Residence',
                              color: LoanTrackColors.PrimaryTwoVeryLight,
                            ),
                          ),
                          separatorSpace5,
                          const Text(
                            'Tell us which city in the country you currently live in.',
                            style: TextStyle(
                              color: LoanTrackColors.PrimaryTwoVeryLight,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      separatorSpace20,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () => LoanTrackModal.modal(
                              context,
                              height: screenHeight / 3,
                              content: Column(
                                  //crossAxisAlignment: CrossAxisAlignment.center,
                                  children: List.generate(
                                      AppLists.countries.length,
                                      (index) => GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                nationalityController.text =
                                                    AppLists.countries[index];
                                                Navigator.pop(context);
                                              });
                                            },
                                            child: ListTile(
                                              title: Text(
                                                AppLists.countries[index],
                                                style: const TextStyle(
                                                  color: LoanTrackColors
                                                      .PrimaryTwoVeryLight,
                                                ),
                                              ),
                                            ),
                                          ))),
                              title: 'Nationality',
                            ),
                            child: LoanTrackTextField(
                              enable: false,
                              controller: nationalityController,
                              label: 'Nationality',
                              color: LoanTrackColors.PrimaryTwoVeryLight,
                            ),
                          ),
                          separatorSpace5,
                          const Text(
                            'Which country are you originally from?',
                            style: TextStyle(
                              color: LoanTrackColors.PrimaryTwoVeryLight,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),

                      separatorSpace80,

                      Text(
                        'SAMARITAN',
                        style: smallTitleStyle(context),
                      ),
                      separatorSpace20,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () => LoanTrackModal.modal(
                              context,
                              height: screenHeight / 5,
                              content: Column(
                                  //crossAxisAlignment: CrossAxisAlignment.center,
                                  children: List.generate(
                                      AppLists.yesNo.length,
                                      (index) => GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                samaritanController.text =
                                                    AppLists.yesNo[index];
                                                Navigator.pop(context);
                                              });
                                            },
                                            child: ListTile(
                                              title: Text(
                                                AppLists.yesNo[index],
                                                style: const TextStyle(
                                                  color: LoanTrackColors
                                                      .PrimaryTwoVeryLight,
                                                ),
                                              ),
                                            ),
                                          ))),
                              title: 'Samaritan',
                            ),
                            child: LoanTrackTextField(
                              controller: samaritanController,
                              enable: false,
                              label: 'I\'m a Samaritan',
                              color: LoanTrackColors.PrimaryTwoVeryLight,
                            ),
                          ),
                          separatorSpace5,
                          const Text(
                            'The Samaritan program allows you to help others repay their loan and you may appeal to someone else who is on the samaritan program to aid you in paying off your own loans.',
                            style: TextStyle(
                              color: LoanTrackColors.PrimaryTwoVeryLight,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      separatorSpace20,
                      LoanTrackButton.primary(
                          whenPressed: () {
                            DatabaseService db = DatabaseService();

                            String firstname = firstnameController.text;
                            String lastname = lastnameController.text;
                            String age = ageController.text;
                            String gender = genderController.text;
                            String maritalStatus = maritalStatusController.text;
                            String totalMonthlyIncome =
                                totalMonthlyIncomeController.text;
                            String occupation = occupationController.text;
                            String industry = occupationIndustryController.text;
                            String countryOfResidence =
                                countryOfResidenceController.text;
                            String cityOfResidence =
                                cityOfResidenceController.text;
                            String nationality = nationalityController.text;
                            String isSamaritan = samaritanController.text;
                            String entryDate = DateTime.now().toIso8601String();

                            String errorMessage = '';

                            if (firstname.isEmpty ||
                                lastname.isEmpty ||
                                age.isEmpty ||
                                gender.isEmpty ||
                                maritalStatus.isEmpty ||
                                totalMonthlyIncome.isEmpty ||
                                occupation.isEmpty ||
                                industry.isEmpty ||
                                countryOfResidence.isEmpty ||
                                cityOfResidence.isEmpty ||
                                nationality.isEmpty ||
                                isSamaritan.isEmpty) {
                              errorMessage +=
                                  'All fields are required. Check your entries.';
                            } else if (!age.isNum ||
                                !totalMonthlyIncome.isNum) {
                              errorMessage +=
                                  'Age and Occupation must contain only numbers from 0 to 9';
                            }

                            print(errorMessage.length);

                            if (errorMessage.length < 1) {
                              db
                                  .updateUserData(
                                firstName: firstname,
                                lastName: lastname,
                                age: age,
                                gender: gender,
                                married: maritalStatus,
                                totalMonthlyIncome: totalMonthlyIncome,
                                occupation: occupation,
                                industry: industry,
                                countryOfResidence: countryOfResidence,
                                cityOfResidence: cityOfResidence,
                                nationality: nationality,
                                isSamaritan: isSamaritan,
                                entryDate: entryDate,
                              )
                                  .whenComplete(() {
                                preferences.setMaritalStatus(maritalStatus);
                                preferences.setMonthlyIncome(
                                    double.parse(totalMonthlyIncome));
                                showSuccessDialog(
                                    context: context,
                                    title: 'Update Profile',
                                    successMessage:
                                        'Your user profile has been successfully updated. We are now able to provide you with details of your Credits Score and Loan Health.',
                                    whenTapped: () {
                                      Navigator.pushNamed(context, '/home');
                                      Notifications notification =
                                          Notifications();
                                      notification.showNotification(
                                          context: context,
                                          title: 'User Data Update',
                                          body:
                                              'Your user profile has been successfully updated. We are now able to provide you with details of your Credits Score and Loan Health.');
                                    });
                              }).onError((error, stackTrace) {
                                showErrorDialog(
                                    context: context,
                                    title: 'Update User Error',
                                    errorMessage:
                                        'An error occurred while updating your profile record');
                              });
                            } else {
                              showErrorDialog(
                                  context: context,
                                  title: 'Entry Error!',
                                  errorMessage: errorMessage);
                            }
                          },
                          context: context,
                          label: 'Continue'),
                      separatorSpace40,
                    ],
                  ),
                ),
                Container(
                  color: Theme.of(context).colorScheme.background,
                  height: screenHeight / 2.6,
                  child: Column(
                    children: [
                      separatorSpace40,
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.close)),
                      Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Edit Your \nProfile',
                              style: titleStyle(context),
                            ),
                            separatorSpace5,
                            const Text(
                              'Welcome to Edit Profile space. Here you can tell us more about you. Telling us more about you will aid us in personalizing your experience.',
                              style: TextStyle(
                                color: LoanTrackColors.PrimaryTwoVeryLight,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          : Center(
              child: Container(
                margin: EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "You have already updated your personal details. If you need to make changes, kindly do so from your 'Dashboard' under 'Profile'",
                      style: bodyStyle(context),
                      textAlign: TextAlign.center,
                    ),
                    separatorSpace20,
                    OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Go Back',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                          ),
                        )),
                  ],
                ),
              ),
            ),
    );
  }
}
