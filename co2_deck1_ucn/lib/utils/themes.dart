import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final ThemeData lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1F2937), foregroundColor: Colors.white),
    navigationBarTheme: NavigationBarThemeData(
        iconTheme: MaterialStateProperty.all(IconThemeData(size: 35.sp)),
        height: 65.sp,
        backgroundColor: Colors.white,
        indicatorColor: Colors.blue.shade100,
        labelTextStyle: MaterialStateProperty.all(
          const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        )),
    textTheme: TextTheme(
        bodySmall:
            TextStyle(fontFamily: 'Leto', fontSize: 16.sp, color: Colors.black),
        bodyMedium:
            TextStyle(fontFamily: 'Leto', fontSize: 18.sp, color: Colors.black),
        bodyLarge:
            TextStyle(fontFamily: 'Leto', fontSize: 20.sp, color: Colors.black),
        labelSmall: TextStyle(
            fontFamily: 'Leto',
            fontSize: 16.sp,
            color: const Color.fromARGB(255, 77, 119, 157),
            fontWeight: FontWeight.bold),
        labelMedium: TextStyle(
            fontFamily: 'Leto',
            fontSize: 18.sp,
            color: const Color.fromARGB(255, 77, 119, 157),
            fontWeight: FontWeight.bold),
        labelLarge: TextStyle(
          fontFamily: 'Leto',
          fontSize: 20.sp,
          color: const Color.fromARGB(255, 77, 119, 157),
          fontWeight: FontWeight.bold,
        ),
        displaySmall: TextStyle(
            fontFamily: 'BebasNeue',
            fontSize: 30.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black),
        displayMedium: TextStyle(
            fontFamily: 'BebasNeue',
            fontSize: 45.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black)),
    colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFF09A6D7),
        onPrimary: Colors.white,
        secondary: Color(0xFF09A6D7),
        onSecondary: Colors.white,
        error: Colors.black,
        onError: Colors.white,
        background: Colors.white,
        onBackground: Colors.black,
        surface: Colors.white,
        onSurface: Colors.black));

final ThemeData darkTheme = ThemeData(
    appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1F2937), foregroundColor: Colors.white),
    navigationBarTheme: NavigationBarThemeData(
      height: 65.sp,
      backgroundColor: const Color.fromRGBO(46, 46, 46, 1),
      indicatorColor: Colors.blue.shade100,
      labelTextStyle: MaterialStateProperty.all(
          TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500)),
    ),
    textTheme: TextTheme(
        bodySmall:
            TextStyle(fontFamily: 'Leto', fontSize: 16.sp, color: Colors.white),
        bodyMedium:
            TextStyle(fontFamily: 'Leto', fontSize: 18.sp, color: Colors.white),
        bodyLarge:
            TextStyle(fontFamily: 'Leto', fontSize: 20.sp, color: Colors.white),
        labelSmall: TextStyle(
          fontFamily: 'Leto',
          fontSize: 16.sp,
          color: const Color.fromARGB(255, 121, 175, 225),
          fontWeight: FontWeight.bold,
        ),
        labelMedium: TextStyle(
          fontFamily: 'Leto',
          fontSize: 18.sp,
          color: const Color.fromARGB(255, 121, 175, 225),
          fontWeight: FontWeight.bold,
        ),
        labelLarge: TextStyle(
          fontFamily: 'Leto',
          fontSize: 20.sp,
          color: const Color.fromARGB(255, 121, 175, 225),
          fontWeight: FontWeight.bold,
        ),
        displaySmall: TextStyle(
            fontFamily: 'BebasNeue',
            fontSize: 30.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white),
        displayMedium: TextStyle(
            fontFamily: 'BebasNeue',
            fontSize: 45.sp,
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
