import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:namer_app/Service/AppTheme.dart';
import 'package:namer_app/Sreen/LogIn.dart';
import 'package:namer_app/Sreen/SignUpFrame.dart';
import 'package:namer_app/Sreen/SplashScreen.dart';
import 'package:provider/provider.dart';

import 'Sreen/Home.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => SearchBoxModel(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: AppTheme().getColor()),
      initialRoute: '/',
      routes: {
        '/': (context) =>  SplashScreen(),
        '/Home':(context) => Home(),
        '/LogIn': (context) => LogIn()
      },
    ),
  ));
}
