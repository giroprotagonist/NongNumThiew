import 'package:flutter/material.dart';
import 'package:nongnumtheiw/states/authen.dart';
import 'package:nongnumtheiw/states/create_account.dart';
import 'package:nongnumtheiw/states/detail_shop.dart';
import 'package:nongnumtheiw/states/home.dart';
import 'package:nongnumtheiw/states/intro.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => Authen(),
  '/createAccount': (BuildContext context) => CreateAccount(),
  '/detailShop': (BuildContext context) => DetailShop(),
  '/home': (BuildContext context) => Home(),
  '/intro': (BuildContext context) => Intro(),
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
    );
  }
}
