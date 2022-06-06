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

const seed = Color(0xFF6750A4);

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF6750A4),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFEADDFF),
  onPrimaryContainer: Color(0xFF21005D),
  secondary: Color(0xFF625B71),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFE8DEF8),
  onSecondaryContainer: Color(0xFF1D192B),
  tertiary: Color(0xFF7D5260),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFFFD8E4),
  onTertiaryContainer: Color(0xFF31111D),
  error: Color(0xFFB3261E),
  errorContainer: Color(0xFFF9DEDC),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410E0B),
  background: Color(0xFFFFFBFE),
  onBackground: Color(0xFF1C1B1F),
  surface: Color(0xFFFFFBFE),
  onSurface: Color(0xFF1C1B1F),
  surfaceVariant: Color(0xFFE7E0EC),
  onSurfaceVariant: Color(0xFF49454F),
  outline: Color(0xFF79747E),
  onInverseSurface: Color(0xFFF4EFF4),
  inverseSurface: Color(0xFF313033),
  inversePrimary: Color(0xFFD0BCFF),
  shadow: Color(0xFF000000),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFD0BCFF),
  onPrimary: Color(0xFF381E72),
  primaryContainer: Color(0xFF4F378B),
  onPrimaryContainer: Color(0xFFEADDFF),
  secondary: Color(0xFFCCC2DC),
  onSecondary: Color(0xFF332D41),
  secondaryContainer: Color(0xFF4A4458),
  onSecondaryContainer: Color(0xFFE8DEF8),
  tertiary: Color(0xFFEFB8C8),
  onTertiary: Color(0xFF492532),
  tertiaryContainer: Color(0xFF633B48),
  onTertiaryContainer: Color(0xFFFFD8E4),
  error: Color(0xFFF2B8B5),
  errorContainer: Color(0xFF8C1D18),
  onError: Color(0xFF601410),
  onErrorContainer: Color(0xFFF9DEDC),
  background: Color(0xFF1C1B1F),
  onBackground: Color(0xFFE6E1E5),
  surface: Color(0xFF1C1B1F),
  onSurface: Color(0xFFE6E1E5),
  surfaceVariant: Color(0xFF49454F),
  onSurfaceVariant: Color(0xFFCAC4D0),
  outline: Color(0xFF938F99),
  onInverseSurface: Color(0xFF1C1B1F),
  inverseSurface: Color(0xFFE6E1E5),
  inversePrimary: Color(0xFF6750A4),
  shadow: Color(0xFF000000),
);
