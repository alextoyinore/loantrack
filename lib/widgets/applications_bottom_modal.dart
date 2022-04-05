import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loantrack/helpers/colors.dart';

class LoanTrackModal {
  static modal(BuildContext context, Widget content, String title) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    showModalBottomSheet(
        backgroundColor: Colors.white.withOpacity(0),
        context: context,
        builder: (context) {
          return Container(
            width: screenWidth,
            //height: screenHeight * 8,
            decoration: const BoxDecoration(
                color: LoanTrackColors.PrimaryTwo,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: screenWidth,
                  height: 50,
                  decoration: const BoxDecoration(
                      color: LoanTrackColors.PrimaryTwo,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Text(title.toUpperCase(),
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
                SizedBox(height: 5),
                Container(
                  height: screenHeight / 2.05,
                  padding: const EdgeInsets.all(16.0),
                  child: content,
                ),
              ],
            ),
          );
        });
  }
}
