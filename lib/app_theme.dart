import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  brightness: Brightness.light,
  primaryColor: Colors.white,
  buttonColor: Color(0xFF1C293D),
  splashColor: Colors.transparent,
  hoverColor: Colors.transparent,
  highlightColor: Colors.transparent,
  textTheme: TextTheme(
      bodyText1: TextStyle(
          color: Color(0xFF1C293D),
          fontSize: 33,
          fontWeight: FontWeight.bold,
          fontFamily: 'Montserrat'),
      bodyText2: TextStyle(
          color: Color(0xFF1C293D),
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'Lato'),
      button: TextStyle(
          color: Color(0xFF1C293D),
          fontWeight: FontWeight.bold,
          fontFamily: 'Montserrat',
          fontSize: 24)),
  textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.black12),
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          textStyle: MaterialStateProperty.all(TextStyle(
              color: Color(0xFF1C293D),
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
              fontSize: 20)))),
  accentColor: Colors.transparent,
  hintColor: Color(0xFFF1592D),
);
