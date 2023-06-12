import 'dart:isolate';
import 'dart:ui';

import 'package:afaq_alnour_academy/bloc/child_bloc/child_cubit.dart';
import 'package:afaq_alnour_academy/screen/child_view/child_screen.dart';
import 'package:afaq_alnour_academy/screen/child_view/main_screen.dart';
import 'package:afaq_alnour_academy/screen/first_screen.dart';
import 'package:afaq_alnour_academy/screen/parent_view/afaq_layout.dart';
import 'package:afaq_alnour_academy/screen/parent_view/on_boarding_screen.dart';

import 'package:afaq_alnour_academy/screen/splash_screen.dart';
import 'package:afaq_alnour_academy/screen/welcome_screen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';

import 'bloc/home_bloc/home_cubit.dart';
import 'bloc/home_bloc/home_state.dart';
import 'bloc/login_bloc/login_cubit.dart';
import 'bloc/register_bloc/register_cubit.dart';
import 'constant/const.dart';
import 'data/local/cache_helper.dart';
import 'generated/l10n.dart';

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget? firstScreen;

  ReceivePort receivePort = ReceivePort();

  @override
  void initState() {
    IsolateNameServer.registerPortWithName(
        receivePort.sendPort, "downloader_send_port");
    receivePort.listen((message) {});
    FlutterDownloader.registerCallback(ChildCubit.downloadCallBack);
    super.initState();
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool? firstscreens = CacheHelper.getData(key: 'first');
    bool? onboardingscreen = CacheHelper.getData(key: 'on_boarding');
    String? loginscreen = CacheHelper.getData(key: 'token_student');
    String? loginChild = CacheHelper.getData(key: 'token_child');

    firstScreen = FirstScreen();
    if (firstscreens != null) {
      firstScreen = On_Boarding_Screen();
      if (onboardingscreen != null) {
        firstScreen = WelcomeScreen();
        if (loginscreen != null) {
          firstScreen = AfaqLayout();
        }
        if (loginChild != null) {
          firstScreen = MainScreen();
        }
      }
    }
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit()
            ..getCourses()
            // ..getPackages()
            ..getMyChildren()
            ..initCardList()
            ..getSlider(),
        ),
        BlocProvider(
          create: (context) => RegisterCubit()..initUser(),
        ),
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => ChildCubit()..getMyCourses(),
        )
      ],
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          var get = HomeCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            useInheritedMediaQuery: true,
            supportedLocales: S.delegate.supportedLocales,
            locale: get.locale =
                Locale('${get.lang == null ? "en" : get.lang}'),
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            title: 'Afaq Alnour Academy',
            theme: ThemeData(
                scaffoldBackgroundColor: HexColor('#E9F2DF'),
                primaryColor: HexColor('#E9F2DF'),
                textTheme: TextTheme(
                    subtitle1: TextStyle(
                        fontSize: 32,
                        color: HexColor("#81AC8C"),
                        fontFamily: primaryfont),
                    bodyText1: TextStyle(
                        color: HexColor("#81AC8C"),
                        fontSize: 16,
                        fontFamily: primaryfont),
                    bodyText2: TextStyle(
                        color: HexColor("#81AC8C"),
                        fontSize: 20,
                        fontFamily: primaryfont,
                        fontWeight: FontWeight.bold),
                    headline3: TextStyle(
                        color: HexColor("#81AC8C"),
                        fontSize: 24,
                        fontFamily: primaryfont,
                        fontWeight: FontWeight.bold),
                    headline4: TextStyle(
                        color: HexColor("#81AC8C"),
                        fontSize: 20,
                        fontFamily: primaryfont),
                    headline5: TextStyle(
                        color: HexColor("#81AC8C"),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: primaryfont)),
                appBarTheme: AppBarTheme(
                    color: HexColor('#E9F2DF'),
                    elevation: 0,
                    titleTextStyle: TextStyle(
                        color: HexColor("#81AC8C"),
                        fontWeight: FontWeight.bold,
                        fontFamily: primaryfont,
                        fontSize: 24),
                    iconTheme: IconThemeData(color: Colors.black)),
                iconTheme: IconThemeData(color: Colors.black, size: 24),
                primarySwatch: Colors.indigo,
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    elevation: 0,
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.teal,
                    unselectedItemColor: Colors.grey,
                    backgroundColor: HexColor('#E9F2DF'))),
            // builder: DevicePreview.appBuilder,
            themeMode: ThemeMode.light,
            home: AnimatedSplashScreen(
              splash: SplashScreen(),
              nextScreen: firstScreen!,
              backgroundColor: Colors.white,
              splashIconSize: double.infinity,
              animationDuration: Duration(milliseconds: 500),
              duration: 6300,
              splashTransition: SplashTransition.fadeTransition,
              pageTransitionType: PageTransitionType.leftToRightWithFade,
            ),
          );
        },
      ),
    );
  }
}
