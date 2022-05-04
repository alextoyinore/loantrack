import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loantrack/apps/repayment_list_app.dart';
import 'package:loantrack/apps/home.dart';
import 'package:loantrack/apps/widgets/loan_detail.dart';
import 'package:loantrack/apps/loan_list_app.dart';
import 'package:loantrack/apps/login_app.dart';
import 'package:loantrack/apps/widgets/news.dart';
import 'package:loantrack/apps/providers/login_states.dart';
import 'package:provider/provider.dart';

import 'apps/loan_record_app.dart';
import 'helpers/colors.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.transparent,
  ));
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => LoginState()),
    ],
    child: Main(),
  ));
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Loantrack',
      theme: ThemeData(
        // This is the theme of your application.
        textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme,
        ),
        appBarTheme: Theme.of(context).appBarTheme.copyWith(
              systemOverlayStyle: SystemUiOverlayStyle.light,
              backgroundColor: LoanTrackColors.PrimaryOne,
            ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoanTackLogin(),
        '/home': (context) => LoanTrackHome(),
        '/loanRecord': (context) => LoanRecord(edit: false),
        'loanHistory': (context) => LoanTrackingPage(
            loanListHeight: MediaQuery.of(context).size.height * .8,
            isHome: false),
        '/loanDetail': (context) => LoanDetail(),
        '/repaymentHistory': (context) => const RepaymentHistory(),
        '/news': (context) => const News(),
      },
    );
  }
}
