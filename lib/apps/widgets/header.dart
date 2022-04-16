import 'package:flutter/material.dart';
import 'package:loantrack/widgets/loan_track_modal.dart';

import '../../data/local.dart';
import '../../helpers/colors.dart';
import '../../helpers/icons.dart';
import '../../widgets/application_grid_view.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              onTap: () {
                LoanTrackModal.modal(context,
                    content: const LoanTrackAppsGridView(),
                    title: 'Applications');
              },
              child: LoanTrackIcons.ApplicationIcon),
          Image.asset(
            'assets/images/loantrack.png',
            height: 20,
          ),
          GestureDetector(
              onTap: () {
                LoanTrackModal.modal(context,
                    content: const SingleChildScrollView(
                        child: Text(LocalData.aboutLoanTrack,
                            style: TextStyle(
                                fontSize: 16,
                                height: 1.5,
                                color: LoanTrackColors.PrimaryTwoLight),
                            softWrap: true)),
                    title: 'About');
              },
              child: Icon(Icons.info_outline))
        ],
      ),
    );
  }
}
