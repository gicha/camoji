import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:cupertino_back_gesture/cupertino_back_gesture.dart';

import 'global/i18n.dart';
import 'providers/init.dart';
import 'providers/ros.dart';
import 'screens/boarding/index.dart';
import 'screens/main/index.dart';
import 'package:intl/intl.dart';

import 'screens/splash/index.dart';

final bool isInDebugMode = true;
final globalNavigatorKey = GlobalKey<NavigatorState>();

void main() async {
  FlutterError.onError = (FlutterErrorDetails details) {
    if (isInDebugMode)
      FlutterError.dumpErrorToConsole(details);
    else
      Zone.current.handleUncaughtError(
        details.exception,
        details.stack,
      );
  };

  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Intl.defaultLocale = "ru";
  runZonedGuarded(() {
    startHome();
  }, (error, stackTrace) async {
    print('Caught error: $error');
    print(stackTrace);
  });
}

startHome() {
  runApp(
    BackGestureWidthTheme(
      backGestureWidth: BackGestureWidth.fraction(1 / 2),
      child: CupertinoApp(
        title: "PhotoLocal".i18n,
        navigatorKey: globalNavigatorKey,
        showSemanticsDebugger: false,
        debugShowCheckedModeBanner: false,
        theme: CupertinoThemeData(),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', 'US'),
          const Locale('ru', 'RU'),
        ],
        builder: (context, child) {
          ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
            return Container(
              color: Colors.black,
              child: Text(
                "Unexpected error. Please try later".i18n,
                style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Colors.white,
                    ),
              ),
            );
          };
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => InitProvider()),
              ChangeNotifierProvider(create: (_) => RosProvider()),
            ],
            child: I18n(child: child),
          );
        },
        home: Consumer<InitProvider>(
          builder: (_, InitProvider p, __) {
            switch (p.state) {
              case InitState.boarding:
                return BoardingScreen();
              case InitState.auth:
                return MainScreen();
              case InitState.inited:
                return MainScreen();
              case InitState.loading:
              default:
                return SplashScreen();
            }
          },
        ),
      ),
    ),
  );
}
