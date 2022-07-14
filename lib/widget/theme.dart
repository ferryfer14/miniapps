import 'package:flutter/material.dart';

var lightThemeData = new ThemeData(
    primaryColor: Color(0xffff972f),
    hintColor: Color(0xff5c5c5c),
    cardColor: Color(0xff522D07),
    textTheme: new TextTheme(
        button: TextStyle(fontFamily: 'Proxima', color: Colors.black)),
    brightness: Brightness.light,
    accentColor: Colors.blue);

var darkThemeData = ThemeData(
    primaryColor: Colors.blue,
    textTheme: new TextTheme(button: TextStyle(color: Colors.black54)),
    brightness: Brightness.dark,
    accentColor: Colors.blue);
