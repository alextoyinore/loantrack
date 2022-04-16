import 'package:flutter/material.dart';
import 'package:loantrack/helpers/colors.dart';

class LoanTrackButton {
  static primary(
      {required BuildContext context,
      required String label,
      BorderRadius? borderRadius}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
          border: Border.all(color: LoanTrackColors.PrimaryOne),
          borderRadius: borderRadius,
          color: LoanTrackColors.PrimaryOne),
      child: Text(
        label,
        style: const TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
        softWrap: true,
      ),
    );
  }

  static primaryOutline(
      {required BuildContext context,
      required String label,
      BorderRadius? borderRadius}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: Colors.white,
          border: Border.all(color: LoanTrackColors.PrimaryOne)),
      child: Text(
        label,
        style: const TextStyle(
            color: LoanTrackColors.PrimaryOne,
            fontSize: 16,
            fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
        softWrap: true,
      ),
    );
  }

  static secondary(
      {required BuildContext context,
      required String label,
      BorderRadius? borderRadius}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
          border: Border.all(color: LoanTrackColors.PrimaryTwo),
          borderRadius: borderRadius,
          color: LoanTrackColors.PrimaryTwo),
      child: Text(
        label,
        style: const TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
        softWrap: true,
      ),
    );
  }

  static secondaryOutline(
      {required BuildContext context,
      required String label,
      BorderRadius? borderRadius}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: Colors.white,
          border: Border.all(color: LoanTrackColors.PrimaryTwoVeryLight)),
      child: Text(
        label,
        style: const TextStyle(
            color: LoanTrackColors.PrimaryTwo,
            fontSize: 16,
            fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
        softWrap: true,
      ),
    );
  }
}
