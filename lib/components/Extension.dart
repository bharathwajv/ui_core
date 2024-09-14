import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

extension BuildContextExtensions on BuildContext {
  ColorScheme get colorScheme => theme.colorScheme;

  TextTheme get textTheme => theme.textTheme;

  ThemeData get theme => Theme.of(this);
}

extension Extension on Object {
  bool isNullOrEmpty() => this == '';
}

extension NumberExtension on num {
  /// Eg: 20.h -> will take 20% of the screen's height
  double get height => h;

  double get scalablePixel => sp;

  double? get tsp {
    return sp * .90;
  }

  /// Eg: 20.h -> will take 20% of the screen's width
  double get width => w;
}

extension TextExtensions on TextTheme {
  TextStyle justColor(color) {
    return TextStyle(color: color);
  }

  TextStyle modifiedTextTheme(TextStyle? textTheme, Color color) {
    return textTheme?.merge(
          TextStyle(
            color: color,
          ),
        ) ??
        justColor(color);
  }
}
