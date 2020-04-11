import 'package:flutter/material.dart';
import 'package:news/splash.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

          primaryColor: Colors.white,
        canvasColor: Colors.grey.shade200,
      ),
        localizationsDelegates: [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ],
  supportedLocales: [
    Locale("ar"), 
  ],
  locale: Locale("ar"),
      home:SplashScreen(),
    );
  }
}
