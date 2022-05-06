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
          border: Border.all(color: LoanTrackColors.PrimaryOne, width: .5),
          borderRadius: borderRadius,
          color: LoanTrackColors.PrimaryOne),
      child: Text(
        label,
        style: const TextStyle(
            color: Colors.white, fontSize: 14, fontWeight: FontWeight.w300),
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
          //color: Colors.white,
          border: Border.all(color: LoanTrackColors.PrimaryOne, width: .5)),
      child: Text(
        label,
        style: const TextStyle(
            color: LoanTrackColors.PrimaryOne,
            fontSize: 14,
            fontWeight: FontWeight.w300),
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
          border: Border.all(color: LoanTrackColors.PrimaryTwo, width: .5),
          borderRadius: borderRadius,
          color: LoanTrackColors.PrimaryTwo),
      child: Text(
        label,
        style: const TextStyle(
            color: Colors.white, fontSize: 14, fontWeight: FontWeight.w300),
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
          //color: Colors.white,
          border: Border.all(color: LoanTrackColors.PrimaryTwo, width: .5)),
      child: Text(
        label,
        style: const TextStyle(
            color: LoanTrackColors.PrimaryTwo,
            fontSize: 14,
            fontWeight: FontWeight.w300),
        textAlign: TextAlign.center,
        softWrap: true,
      ),
    );
  }
}
