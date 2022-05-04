import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loantrack/helpers/colors.dart';
import 'package:loantrack/helpers/common_widgets.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  var user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        children: [
          //separatorSpace20,
          const CircleAvatar(
            backgroundImage: AssetImage('assets/images/user_profile.png'),
            radius: 50,
          ),
          Text(
            user!.displayName.toString(),
            style: const TextStyle(
                fontSize: 18, color: LoanTrackColors.PrimaryTwoVeryLight),
          ),
          separatorLine,
        ],
      ),
    );
  }
}