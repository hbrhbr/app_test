import 'package:flutter/material.dart';

ThemeData light({Color color = const Color(0xFF2E2739)}) => ThemeData(
      fontFamily: 'poppins',
      primaryColor: color,
      primaryColorLight: Colors.white,
      primaryColorDark: Colors.black,
      secondaryHeaderColor: const Color(0xFF2E2739).withOpacity(0.60),
      disabledColor: const Color(0x20000000),
      brightness: Brightness.light,
      hintColor:  Colors.black26,
      scaffoldBackgroundColor: const Color(0xFFFFFFFF),
      cardColor: Colors.white,
      textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: color)), colorScheme: ColorScheme.light(primary: color, secondary: const Color(0xFF2E2739).withOpacity(0.60)).copyWith(background: const Color(0x09000000)).copyWith(error: const Color(0xFFE84D4F)),
    );
