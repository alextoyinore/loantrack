import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loantrack/apps/home.dart';
import 'package:loantrack/apps/loan_list_app.dart';
import 'package:loantrack/apps/login_app.dart';
import 'package:loantrack/apps/providers/loan_provider.dart';
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
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginState()),
        ChangeNotifierProvider(create: (_) => ThemeManager()),
        ChangeNotifierProvider(create: (_) => LoanDetailsProviders()),
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
  int storedThemeNumber = 0;

  Future<void> getThemeNumber() async {
    ThemePreferences themePreferences = ThemePreferences();
    int themeNumber = await themePreferences.getThemeNumber();
    setState(() {
      storedThemeNumber = themeNumber;
    });
  }

  @override
  void initState() {
    getThemeNumber();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print(storedThemeNumber);
    }

    context.watch<ThemeManager>().themeNumber;
    var newlySetTheme = context.read<ThemeManager>().themeNumber;

    if (newlySetTheme > -1) {
      setState(() {
        storedThemeNumber = newlySetTheme;
      });
    }

    // Run App
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness:
          (storedThemeNumber == 2) ? Brightness.dark : Brightness.light,
      statusBarIconBrightness:
          (storedThemeNumber == 1) ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: (storedThemeNumber == 1)
          ? lightColorScheme.background
          : (storedThemeNumber == 0)
              ? seed.withOpacity(.8)
              : darkColorScheme.background,
      systemNavigationBarIconBrightness:
          (storedThemeNumber == 2) ? Brightness.dark : Brightness.light,
      statusBarColor: Colors.transparent,
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Loantrack',
      themeMode: (storedThemeNumber == 1)
          ? ThemeMode.light
          : (storedThemeNumber == 2)
              ? ThemeMode.dark
              : ThemeMode.system,

      // Light Theme
      theme: ThemeData(
        scaffoldBackgroundColor: lightColorScheme.background,
        colorScheme: lightColorScheme,
        textTheme: GoogleFonts.quicksandTextTheme(
          Theme.of(context).textTheme,
        ),
        iconTheme: IconThemeData(color: lightColorScheme.primary),
        appBarTheme: Theme.of(context).appBarTheme.copyWith(
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              backgroundColor: lightColorScheme.background,
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
              backgroundColor: darkColorScheme.background,
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
