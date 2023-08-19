import 'package:flutter/material.dart';

import 'package:responsivedashboard/constants.dart';

class MyThemes {
  BuildContext ctx;
  MyThemes({required this.ctx});

  darkTheme() {
    return ThemeData(
        appBarTheme: AppBarTheme(
            color: const Color(0xFF00001a),
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.grey[600])),
        drawerTheme: const DrawerThemeData(backgroundColor: Colors.black),
        scaffoldBackgroundColor: const Color(0xFF00001a),
        primaryColor: primaryColor,
        colorScheme: ThemeData().colorScheme.copyWith(
              secondary: const Color(0xFF1a1f3c),
              brightness: Brightness.dark,
            ),
        cardColor: const Color(0xFF0a0d2c),
        // canvasColor: Colors.black,
        buttonTheme: Theme.of(ctx)
            .buttonTheme
            .copyWith(colorScheme: const ColorScheme.dark()));
  }

  lightTheme() {
    return ThemeData(
      appBarTheme: AppBarTheme(
          color: const Color(0xFFFFFFFF),
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.grey[600])),
      drawerTheme: const DrawerThemeData(backgroundColor: Color(0xFFFFFFFF)),
      scaffoldBackgroundColor: const Color(0xFFFFFFFF),
      colorScheme: ThemeData().colorScheme.copyWith(
            secondary: const Color(0xFFE9FCFC),
            brightness: Brightness.light,
          ),
      cardColor: const Color(0xFFF2FDFD),
      // canvasColor: Colors.grey[50],
      primaryColor: primaryColor,
    );
  }
}
