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

const seed = Color(0xFF129282);

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF006B5E),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFF75F8E2),
  onPrimaryContainer: Color(0xFF00201B),
  secondary: Color(0xFF4A635E),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFCDE8E1),
  onSecondaryContainer: Color(0xFF06201B),
  tertiary: Color(0xFF446178),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFC9E6FF),
  onTertiaryContainer: Color(0xFF001E31),
  error: Color(0xFFBA1B1B),
  errorContainer: Color(0xFFFFDAD4),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410001),
  background: Color(0xFFFAFDFA),
  onBackground: Color(0xFF191C1B),
  surface: Color(0xFFFAFDFA),
  onSurface: Color(0xFF191C1B),
  surfaceVariant: Color(0xFFDAE5E1),
  onSurfaceVariant: Color(0xFF3F4946),
  outline: Color(0xFF6F7976),
  onInverseSurface: Color(0xFFEFF1EF),
  inverseSurface: Color(0xFF2E3130),
  inversePrimary: Color(0xFF55DBC6),
  shadow: Color(0xFF000000),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF55DBC6),
  onPrimary: Color(0xFF003730),
  primaryContainer: Color(0xFF005046),
  onPrimaryContainer: Color(0xFF75F8E2),
  secondary: Color(0xFFB1CCC5),
  onSecondary: Color(0xFF1C3530),
  secondaryContainer: Color(0xFF334B46),
  onSecondaryContainer: Color(0xFFCDE8E1),
  tertiary: Color(0xFFACCAE5),
  onTertiary: Color(0xFF133349),
  tertiaryContainer: Color(0xFF2C4A60),
  onTertiaryContainer: Color(0xFFC9E6FF),
  error: Color(0xFFFFB4A9),
  errorContainer: Color(0xFF930006),
  onError: Color(0xFF680003),
  onErrorContainer: Color(0xFFFFDAD4),
  background: Color(0xFF191C1B),
  onBackground: Color(0xFFE1E3E1),
  surface: Color(0xFF191C1B),
  onSurface: Color(0xFFE1E3E1),
  surfaceVariant: Color(0xFF3F4946),
  onSurfaceVariant: Color(0xFFBEC9C5),
  outline: Color(0xFF899390),
  onInverseSurface: Color(0xFF191C1B),
  inverseSurface: Color(0xFFE1E3E1),
  inversePrimary: Color(0xFF006B5E),
  shadow: Color(0xFF000000),
);
