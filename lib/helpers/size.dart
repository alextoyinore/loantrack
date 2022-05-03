import 'package:flutter/material.dart';

class LoanTrackSize {
  static screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}
