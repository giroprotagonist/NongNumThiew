import 'package:flutter/material.dart';

class MyStyle {
  Color primary = Color(0xff1976d2);
  Color dark = Color(0xff004ba0);
  Color light = Color(0xff63a4ff);

  TextStyle darkNormalStyle() => TextStyle(color: dark);

  TextStyle darkH1Style() => TextStyle(
        color: dark,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      );

  TextStyle darkH2Style() => TextStyle(
        color: dark,
        fontSize: 16,
        fontWeight: FontWeight.w700,
      );

      TextStyle darkH3Style() => TextStyle(
        color: dark,
        fontSize: 16,
        // fontWeight: FontWeight.w200,
      );
  MyStyle();
}
