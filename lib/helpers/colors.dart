import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoanTrackColors {
  //Primary1
  static const PrimaryOneDark = Color.fromARGB(255, 1, 84, 117);
  static const PrimaryOne = Color.fromARGB(255, 4, 107, 148);
  static const PrimaryOneLight = Color.fromARGB(255, 83, 191, 234);
  static const PrimaryOneVeryLight = Color.fromARGB(255, 188, 234, 252);

  //Primary2
  static const PrimaryTwo = Color(0xFF222222);
  static const PrimaryTwoDark = Color(0xFF000000);
  static const PrimaryTwoLight = Color(0xFF58595B);
  static const PrimaryTwoVeryLight = Color(0xFFAAAAAA);
  static const PrimaryTwoBright = Color(0xFFCCCCCC);

  // Blacks
  static const TetiaryOne = Color.fromARGB(255, 249, 184, 20);
  static const TetiaryOneLight = Color.fromARGB(255, 254, 228, 162);
}

class LoanTrackColors2 {
  //Primary1
  static const PrimaryOneDark = Color(0xFF393C68);
  static const PrimaryOne = Color(0xFF585B92);
  static const PrimaryOneLight = Color(0xFFDB4F8F);
  static const PrimaryOneVeryLight = Color(0xFEA76AC);

  // Blacks
  static const TetiaryOne = Color.fromARGB(255, 19, 205, 174);
  static const TetiaryOneLight = Color.fromARGB(255, 190, 255, 244);
}

const seed = Color(0xFF046B94);

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF00658E),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFC3E7FF),
  onPrimaryContainer: Color(0xFF001E2E),
  secondary: Color(0xFF4F616E),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFD2E5F4),
  onSecondaryContainer: Color(0xFF0B1D28),
  tertiary: Color(0xFF625A7C),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFE8DDFF),
  onTertiaryContainer: Color(0xFF1E1735),
  error: Color(0xFFBA1B1B),
  errorContainer: Color(0xFFFFDAD4),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410001),
  background: Color(0xFFFBFCFF),
  onBackground: Color(0xFF191C1E),
  surface: Color(0xFFFBFCFF),
  onSurface: Color(0xFF191C1E),
  surfaceVariant: Color(0xFFDDE3EA),
  onSurfaceVariant: Color(0xFF41484D),
  outline: Color(0xFF71787E),
  onInverseSurface: Color(0xFFF0F1F4),
  inverseSurface: Color(0xFF2E3133),
  inversePrimary: Color(0xFF7FCFFF),
  shadow: Color(0xFF000000),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF7FCFFF),
  onPrimary: Color(0xFF00344B),
  primaryContainer: Color(0xFF004C6C),
  onPrimaryContainer: Color(0xFFC3E7FF),
  secondary: Color(0xFFB6C9D8),
  onSecondary: Color(0xFF21333E),
  secondaryContainer: Color(0xFF374955),
  onSecondaryContainer: Color(0xFFD2E5F4),
  tertiary: Color(0xFFCCC1E9),
  onTertiary: Color(0xFF332C4B),
  tertiaryContainer: Color(0xFF4A4263),
  onTertiaryContainer: Color(0xFFE8DDFF),
  error: Color(0xFFFFB4A9),
  errorContainer: Color(0xFF930006),
  onError: Color(0xFF680003),
  onErrorContainer: Color(0xFFFFDAD4),
  background: Color.fromARGB(255, 0, 0, 0),
  onBackground: Color(0xFFE1E2E5),
  surface: Color(0xFF191C1E),
  onSurface: Color(0xFFE1E2E5),
  surfaceVariant: Color(0xFF41484D),
  onSurfaceVariant: Color(0xFFC1C7CE),
  outline: Color(0xFF8B9298),
  onInverseSurface: Color(0xFF191C1E),
  inverseSurface: Color(0xFFE1E2E5),
  inversePrimary: Color(0xFF00658E),
  shadow: Color(0xFF000000),
);
