import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
import 'apps/messages/notifications.dart';
import 'helpers/colors.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  description: 'This channel is used for important notifications.',
  importance: Importance.high,
  playSound: true,
);

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  if (kDebugMode) {
    print('A message just showed up: ${message.messageId}');
  }
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

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
    AppPreferences themePreferences = AppPreferences();
    int themeNumber = await themePreferences.getThemeNumber();
    setState(() {
      storedThemeNumber = themeNumber;
    });
  }

  Notifications notifications = Notifications();

  @override
  void initState() {
    super.initState();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              color: Theme.of(context).colorScheme.primary,
              playSound: true,
              icon: '@mipmap/ic_notification',
            ),
          ),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('A new onMessageOpenedApp event was published!');
      }
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(notification.body!),
                    ],
                  ),
                ),
              );
            });
      }
    });

    getThemeNumber();

    notifications.showNotification(
      context: context,
      title: 'Welcome',
      body:
          'Welcome to Loantrack. Nigeria\'s best loan consumer management app.',
    );
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

    Color bg = Color(0xFFAAAA);

    if (TimeOfDay.now().hour > 18 || TimeOfDay.now().hour < 7) {
      bg = darkColorScheme.background;
    } else {
      bg = lightColorScheme.background;
    }

    // Run App
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness:
          (storedThemeNumber == 2) ? Brightness.dark : Brightness.light,
      statusBarIconBrightness:
          (storedThemeNumber == 1) ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: (storedThemeNumber == 1)
          ? lightColorScheme.background
          : (storedThemeNumber == 2)
              ? darkColorScheme.background
              : bg,
      systemNavigationBarIconBrightness:
          (storedThemeNumber == 2) ? Brightness.light : Brightness.dark,
      statusBarColor: Colors.transparent,
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LoanTrack',
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
        '/': (context) => SplashScreen(),
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
