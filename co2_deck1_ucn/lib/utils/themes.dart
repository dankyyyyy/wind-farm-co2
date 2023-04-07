import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1F2937), foregroundColor: Colors.white),
    textTheme: const TextTheme(
        bodySmall:
            TextStyle(fontFamily: 'Leto', fontSize: 16, color: Colors.black),
        bodyMedium:
            TextStyle(fontFamily: 'Leto', fontSize: 20, color: Colors.black),
        displayMedium: TextStyle(
            fontFamily: 'BebasNeue',
            fontSize: 45,
            fontWeight: FontWeight.bold,
            color: Colors.black)),
    colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFF09A6D7),
        onPrimary: Color(0xFFF65928),
        secondary: Color(0xFF09A6D7),
        onSecondary: Color(0xFFF65928),
        error: Colors.black,
        onError: Colors.white,
        background: Colors.white,
        onBackground: Colors.black,
        surface: Colors.white,
        onSurface: Colors.black));

final ThemeData darkTheme = ThemeData(
    appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1F2937), foregroundColor: Colors.white),
    textTheme: const TextTheme(
        bodySmall:
            TextStyle(fontFamily: 'Leto', fontSize: 16, color: Colors.white),
        bodyMedium:
            TextStyle(fontFamily: 'Leto', fontSize: 20, color: Colors.white),
        displayMedium: TextStyle(
            fontFamily: 'BebasNeue',
            fontSize: 45,
            fontWeight: FontWeight.bold,
            color: Colors.white)),
    colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: Colors.blueGrey,
        onPrimary: Colors.white,
        secondary: Colors.blue,
        onSecondary: Colors.white,
        error: Colors.grey,
        onError: Colors.white,
        background: Colors.grey,
        onBackground: Colors.white,
        surface: Colors.grey,
        onSurface: Colors.white));