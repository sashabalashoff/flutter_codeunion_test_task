import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

ThemeData lightThemeData = themeData(lightColorScheme);
ThemeData darkThemeData = themeData(darkColorScheme);

final textTheme = GoogleFonts.manropeTextTheme();

const ColorScheme lightColorScheme = ColorScheme(
  primary: appPrimaryLight,
  onPrimary: appOnPrimaryLight,
  secondary: appSecondaryLight,
  onSecondary: appOnSecondaryLight,
  background: appBackgroundLight,
  onBackground: appOnBackgroundLight,
  surface: appSurfaceLight,
  onSurface: appOnSurfaceLight,
  error: appErrorLight,
  onError: appOnErrorLight,
  brightness: Brightness.light,
);

const ColorScheme darkColorScheme = ColorScheme(
  primary: appPrimaryDark,
  onPrimary: appOnPrimaryDark,
  secondary: appSecondaryDark,
  onSecondary: appOnSecondaryDark,
  background: appBackgroundDark,
  onBackground: appOnBackgroundDark,
  surface: appSurfaceDark,
  onSurface: appOnSurfaceDark,
  error: appErrorDark,
  onError: appOnErrorDark,
  brightness: Brightness.dark,
);

ThemeData themeData(ColorScheme colorScheme) {
  return ThemeData(
    colorScheme: colorScheme,
    textTheme: textTheme,
    appBarTheme: AppBarTheme(
      color: colorScheme.surface,
      elevation: 0,
      iconTheme: IconThemeData(color: colorScheme.onBackground),
    ),
    canvasColor: colorScheme.background,
    scaffoldBackgroundColor: colorScheme.background,
  );
}
