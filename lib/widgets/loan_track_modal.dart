import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loantrack/helpers/colors.dart';
import 'package:loantrack/widgets/common_widgets.dart';

class LoanTrackModal {
  static modal(BuildContext context,
      {required Widget content,
      required String title,
      double height = 650,
      bool isError = false,
      Exception? e}) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Stack(children: [
            SizedBox(
              width: screenWidth,
              height: height,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    separatorSpace50,
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 5,
                      ),
                      child: (e == null)
                          ? content
                          : Text(
                              e.toString(),
                              softWrap: true,
                            ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              alignment: Alignment.center,
              width: screenWidth,
              height: screenHeight / 16,
              decoration: BoxDecoration(
                  color: !isError
                      ? Colors.white //LoanTrackColors.PrimaryTwo
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
          ]);
        });
  }
}
