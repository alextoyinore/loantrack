import 'package:flutter/material.dart';

class LoanTrackSize {
  static screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}

double widthAllowance(BuildContext context, double screenWidth) {
  if (screenWidth < 400) {
    screenWidth = screenWidth + 10;
  }
  return screenWidth;
}

double heightAllowance(
    BuildContext context, double screenHeight, double screenWidth) {
  if (screenWidth < 400) {
    screenHeight = screenHeight + 10;
  }
  return screenHeight;
}
