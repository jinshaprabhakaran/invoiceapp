import 'dart:io';

import 'package:appdebug_font_package/appdebug_font_package.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'global/constants/providers/providers_list.dart';
import 'global/constants/routes/routes.dart';

void main()async {
    WidgetsFlutterBinding.ensureInitialized(); 
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(MultiProvider(providers: providersList, child: const MyApp()));
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
  return Platform.isIOS
        ? ScreenUtilInit(
            designSize: const Size(333, 675),
            child: CupertinoApp(
                title: 'Invoice',
                routes:  routes,
                initialRoute: '/',
                theme: CupertinoThemeData(
                    barBackgroundColor: KColors().kWhite,
                    primaryColor: Colors.black),
                debugShowCheckedModeBanner: false,
                localizationsDelegates: const [
                  DefaultWidgetsLocalizations.delegate,
                  DefaultMaterialLocalizations.delegate,
                  DefaultCupertinoLocalizations.delegate
                ]),
          )
        : ScreenUtilInit(
            designSize: const Size(333, 675),
            child: MaterialApp(
                routes: routes,
               title: 'Invoice',
                initialRoute: '/',
                debugShowCheckedModeBanner: false,
                theme: ThemeData.light().copyWith(
                  searchBarTheme: SearchBarThemeData(
                      backgroundColor:
                          WidgetStatePropertyAll(KColors().kWhite)),
                )));
  }
}


