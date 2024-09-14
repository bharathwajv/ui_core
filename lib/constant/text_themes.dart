import 'package:flutter/material.dart';
import 'package:ui_core/components/Extension.dart';

// context.textTheme.titleLarge,
// context.textTheme.justColor(textColor)

//context.textTheme.modifiedTextTheme(context.textTheme.labelSmall, AppColors.grey),
class CoreText {
  static TextTheme appTextTheme = TextTheme(
// Headline styles
    headlineLarge: TextStyle(
      fontSize: 32.tsp,
      fontWeight: FontWeight.bold,
    ),
    headlineMedium: TextStyle(
      fontSize: 24.tsp,
      fontWeight: FontWeight.bold,
    ),
    headlineSmall: TextStyle(
      fontSize: 18.tsp,
      fontWeight: FontWeight.bold,
    ),

// Title styles
    titleLarge: TextStyle(
      fontSize: 24.tsp,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(
      fontSize: 20.tsp,
      fontWeight: FontWeight.bold,
    ),
    titleSmall: TextStyle(
      fontSize: 16.tsp,
      fontWeight: FontWeight.bold,
    ),
    displayLarge: TextStyle(
      fontSize: 32.tsp,
    ),
    displayMedium: TextStyle(
      fontSize: 22.tsp,
    ),
    displaySmall: TextStyle(
      fontSize: 18.tsp,
    ),
// Body styles
    bodyLarge: TextStyle(
      fontSize: 18.tsp,
    ),
    bodyMedium: TextStyle(
      fontSize: 16.tsp,
    ),
    bodySmall: TextStyle(
      fontSize: 14.tsp,
    ),

// Label styles
    labelLarge: TextStyle(
      fontSize: 18.tsp,
      fontWeight: FontWeight.bold,
    ),
    labelMedium: TextStyle(
      fontSize: 16.tsp,
      fontWeight: FontWeight.bold,
    ),
    labelSmall: TextStyle(
      fontSize: 14.tsp,
    ),
  );
}
