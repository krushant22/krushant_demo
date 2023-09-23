import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krushant_demo/theme/color/colors.dart';

/// [CustomGetXFontStyle] USE CUSTOM FONT

class CustomGetXFontStyle {
  static TextTheme get primaryTextTheme => ThemeData().textTheme.apply(
        fontFamily: GoogleFonts.lexend(color: primaryTextColor).fontFamily,
      );
}
