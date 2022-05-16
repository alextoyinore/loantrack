import 'package:flutter/material.dart';
import 'package:loantrack/helpers/colors.dart';

class LoanTrackButton {
  static primary({
    required BuildContext context,
    required String label,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
          border: Border.all(color: LoanTrackColors.PrimaryOne, width: .5),
          borderRadius: BorderRadius.circular(5),
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

  static primaryOutline({
    required BuildContext context,
    required String label,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
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

  static secondary({
    required BuildContext context,
    required String label,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
          border: Border.all(color: LoanTrackColors.PrimaryTwo, width: .5),
          borderRadius: BorderRadius.circular(5),
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

  static secondaryOutline({
    required BuildContext context,
    required String label,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          //color: Colors.white,
          border: Border.all(
              color: LoanTrackColors.PrimaryTwoVeryLight, width: .5)),
      child: Text(
        label,
        style: const TextStyle(
            color: LoanTrackColors.PrimaryTwoLight,
            fontSize: 14,
            fontWeight: FontWeight.w300),
        textAlign: TextAlign.center,
        softWrap: true,
      ),
    );
  }

  static error({
    required BuildContext context,
    required String label,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.red,
          width: .5,
        ),
        borderRadius: BorderRadius.circular(5),
        color: Colors.red,
      ),
      child: Text(
        label,
        style: const TextStyle(
            color: Colors.white, fontSize: 14, fontWeight: FontWeight.w300),
        textAlign: TextAlign.center,
        softWrap: true,
      ),
    );
  }
}
