import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loantrack/helpers/colors.dart';

class LoanTrackModal {
  static modal(BuildContext context,
      {required Widget content,
      required String title,
      bool isError = false,
      Exception? e}) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    showModalBottomSheet(
        backgroundColor: Colors.white.withOpacity(0),
        context: context,
        builder: (context) {
          return Container(
            width: screenWidth,
            height: screenHeight * 2,
            decoration: BoxDecoration(
                color: !isError ? Colors.black : Colors.redAccent,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  width: screenWidth,
                  height: 50,
                  decoration: BoxDecoration(
                      color: !isError
                          ? Colors.black //LoanTrackColors.PrimaryTwo
                          : Colors.redAccent,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Text(title.toUpperCase(),
                      style: const TextStyle(
                          fontSize: 20,
                          color: LoanTrackColors.PrimaryTwoLight //Colors.white,
                          )),
                ),
                SizedBox(height: 5),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 5),
                    child: (e == null)
                        ? content
                        : Text(
                            e.toString(),
                            //style: TextStyle(color: Colors.white),
                            softWrap: true,
                          ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
