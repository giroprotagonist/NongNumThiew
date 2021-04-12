import 'package:flutter/material.dart';
import 'package:nongnumtheiw/states/authen.dart';
import 'package:nongnumtheiw/states/create_account.dart';
import 'package:nongnumtheiw/states/denied_forever_page.dart';
import 'package:nongnumtheiw/states/home.dart';
import 'package:nongnumtheiw/states/intro.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => Authen(),
  '/createAccount': (BuildContext context) => CreateAccount(),
  '/home': (BuildContext context) => Home(),
  '/intro': (BuildContext context) => Intro(),
  '/deniedForever':(BuildContext context)=>DeniedForeverPage(),
};

String initialRount = '/home';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nong Num Theiw',
      routes: map,
      initialRoute: initialRount,
      debugShowCheckedModeBanner: false,
    );
  }
}
