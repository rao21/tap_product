import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  static final darkTheme = ThemeData(
      primarySwatch: Colors.grey,
      primaryColor: Color.fromARGB(183, 0, 0, 0),
      primaryColorDark: Colors.black,
      brightness: Brightness.dark,
      disabledColor: Colors.black,
      backgroundColor: Color.fromARGB(34, 34, 34, 0),
      dividerColor: Colors.black12,
      accentColor: Color.fromRGBO(253, 114, 114, 1),
      textTheme: TextTheme(
          headline4: GoogleFonts.lato(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          subtitle1: GoogleFonts.lato(color: Colors.grey, fontSize: 14),
          subtitle2: GoogleFonts.lato(color: Colors.grey, fontSize: 12),
          bodyText1: GoogleFonts.lato(color: Colors.grey, fontSize: 12)));

  static final lightTheme = ThemeData(
      primarySwatch: Colors.grey,
      primaryColor: Colors.white,
      backgroundColor: Color.fromRGBO(249, 249, 249, 1),
      primaryColorDark: Colors.white,
      disabledColor: Colors.white,
      brightness: Brightness.light,
      accentColor: Color.fromRGBO(253, 114, 114, 1),
      textTheme: TextTheme(
          headline4: GoogleFonts.lato(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          subtitle1: GoogleFonts.lato(color: Colors.grey, fontSize: 14),
          subtitle2: GoogleFonts.lato(color: Colors.grey, fontSize: 12),
          bodyText1: GoogleFonts.lato(color: Colors.grey, fontSize: 12)));
}
