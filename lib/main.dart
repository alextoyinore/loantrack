import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loantrack/apps/home.dart';
import 'package:loantrack/apps/loan_list_app.dart';
import 'package:loantrack/apps/login_app.dart';
import 'package:loantrack/apps/providers/login_states.dart';
import 'package:loantrack/apps/providers/preferences.dart';
import 'package:loantrack/apps/providers/theme_provider.dart';
import 'package:loantrack/apps/repayment_list_app.dart';
import 'package:loantrack/apps/screens/splashscreen.dart';
import 'package:loantrack/apps/widgets/loandetail.dart';
import 'package:provider/provider.dart';

import 'apps/loan_record_app.dart';
import 'helpers/colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.transparent,
  ));
  // Run App
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginState()),
        ChangeNotifierProvider(create: (_) => ThemeManager()),
      ],
      child: const Main(),
    ),
  );
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  String storedThemeName = '';

  void getTheme() async {
    ThemePreferences themePreferences = ThemePreferences();
    storedThemeName = await themePreferences.getTheme();
  }

  @override
  void initState() {
    super.initState();
    getTheme();
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print(storedThemeName);
    }
    ThemeStates themeStates = context.watch<ThemeManager>().themeMode;
    var providedTheme = context.read<ThemeManager>().themeMode;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Loantrack',
      themeMode:
          (storedThemeName == 'Light' || providedTheme == ThemeStates.light)
              ? ThemeMode.light
              : (storedThemeName == 'Dark' || providedTheme == ThemeStates.dark)
                  ? ThemeMode.dark
                  : ThemeMode.system,
      // Light Theme
      theme: ThemeData(
        scaffoldBackgroundColor: lightColorScheme.background,
        colorScheme: lightColorScheme,
        textTheme: GoogleFonts.jostTextTheme(
          Theme.of(context).textTheme,
        ),
        iconTheme: IconThemeData(color: lightColorScheme.primary),
        appBarTheme: Theme.of(context).appBarTheme.copyWith(
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              foregroundColor: lightColorScheme.primary,
              backgroundColor: Colors.white,
            ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: lightColorScheme.background,
          selectedItemColor: lightColorScheme.primary,
          selectedLabelStyle: TextStyle(color: lightColorScheme.primary),
          unselectedItemColor: lightColorScheme.secondary.withOpacity(.2),
          showUnselectedLabels: true,
          elevation: 1,
          enableFeedback: false,
          type: BottomNavigationBarType.fixed,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      // Dark Theme
      darkTheme: ThemeData(
        scaffoldBackgroundColor: darkColorScheme.background,
        colorScheme: darkColorScheme,
        textTheme: GoogleFonts.jostTextTheme(
          Theme.of(context).textTheme,
        ),
        appBarTheme: Theme.of(context).appBarTheme.copyWith(
              systemOverlayStyle: SystemUiOverlayStyle.light,
              foregroundColor: darkColorScheme.primary,
              backgroundColor: Colors.black,
            ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: darkColorScheme.background,
          indicatorColor: seed,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: darkColorScheme.background,
          selectedItemColor: seed,
          selectedLabelStyle: TextStyle(color: darkColorScheme.primary),
          unselectedItemColor: darkColorScheme.secondary.withOpacity(.3),
          showUnselectedLabels: true,
          elevation: 1,
          enableFeedback: false,
          type: BottomNavigationBarType.fixed,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoanTrackLogin(),
        '/home': (context) => LoanTrackHome(),
        '/loanRecord': (context) => LoanRecord(edit: false),
        'loanHistory': (context) => LoanTrackingPage(
            loanListHeight: MediaQuery.of(context).size.height * .8,
            isHome: false),
        '/loanDetail': (context) => LoanDetail(),
        '/repaymentHistory': (context) => const RepaymentHistory(),
        /*'/news': (context) => const News(),*/
      },
    );
  }
}
