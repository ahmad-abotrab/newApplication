
import 'package:applicationomar/SecurityClass.dart';
import 'package:applicationomar/views/ChoiceUser/choiceUser.dart';
import 'package:applicationomar/views/Todo/TodoHomePage.dart';
import 'package:applicationomar/widgets/Bottom_Nav.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:page_transition/page_transition.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

import 'localization/localizationFile.dart';
import 'views/Login_Pages/Login_screen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([
    SystemUiOverlay.bottom,
  ]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.grey, // navigation bar color
    statusBarColor: Colors.grey, // status bar color
  ));

  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  bool isDarkTheme = false;
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }

  static void changeMode(BuildContext context) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.changeMode();
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale locale;

  setLocale(Locale locale) {
    setState(() {
      this.locale = locale;
      Security.langaugeCode =
          locale.languageCode == null ? 'en' : locale.languageCode;
    });
  }

  changeMode() {
    setState(() {
      widget.isDarkTheme = !widget.isDarkTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, navigator) {
        var lang = Localizations.localeOf(context).languageCode;
        return Theme(
          data: widget.isDarkTheme
              ? ThemeData(
                  toggleableActiveColor: Color(0xff0e1621),
                  primaryColorDark: Color(0xff489cdc),
                  hintColor: Colors.white,
                  backgroundColor: Color(0xff0e1621),
                  fontFamily: lang == 'ar' ? 'Taj' : 'Raleway',
                  primaryColor: Color(0xff0e1621),
                  appBarTheme: AppBarTheme(
                    elevation: 8,
                    color: Color(0xff0e1621).withOpacity(0.8),
                  ),
                )
              : ThemeData(
                  toggleableActiveColor: Colors.grey[200],
                  primaryColorDark: Color(0xff489cdc),
                  hintColor: Colors.black87,
                  backgroundColor: Colors.white,
                  fontFamily: lang == 'ar' ? 'Taj' : 'Raleway',
                  primaryColor: Colors.grey,
                  appBarTheme: AppBarTheme(
                    elevation: 8,
                    color: Colors.grey,
                  ),
                ),
          child: navigator,
        );
      },
      locale: this.locale,
      localizationsDelegates: [
        DemoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        for (var locale in supportedLocales) {
          if (locale.languageCode == deviceLocale.languageCode &&
              locale.countryCode == deviceLocale.countryCode) {
            return deviceLocale;
          }
        }
        return supportedLocales.first;
        
      },
      supportedLocales: [
        Locale('ar', 'SY'),
        Locale('en', 'US'),
      ],
      debugShowCheckedModeBanner: false,
      title: 'Login Screen',
      routes: {
        '/': (context) => AnimatedSplachScreen(),
        '/login': (context) => LoginScreen(),
        '/choiceUser': (context) => ChoiceUser(),
        '/TodoPage' :(context)=>TodoPage(),
        '/home' :(context)=>BottomNav()
      },
      initialRoute: '/',
      // home: AnimatedSplachScreen(),
    );
  }
}

class AnimatedSplachScreen extends StatelessWidget {
  const AnimatedSplachScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: Icon(
          Icons.menu_book,
          size: 100,
        ),
        duration: 1,
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.bottomToTop,
        nextScreen: LoginScreen());
  }
}

ThemeData darkTheme = ThemeData(
    primaryTextTheme: TextTheme(),
    accentColor: Colors.white,
    brightness: Brightness.dark,
    primaryColor: Colors.black,
    backgroundColor: Colors.blue,
    appBarTheme: AppBarTheme(
      color: Colors.black,
      elevation: 0,
    ));

ThemeData lightTheme = ThemeData(
  accentColor: Colors.blue,
  brightness: Brightness.light,
  primaryColor: Colors.grey,
  backgroundColor: Colors.green,
  appBarTheme: AppBarTheme(
    elevation: 0,
    color: Colors.grey,
  ),
);
