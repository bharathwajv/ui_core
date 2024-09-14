import 'package:flutter/material.dart';

class CoreColors {
// only hard coard colors which will be comon in dark / light theme

  static const Color lightgrey = Color.fromARGB(255, 219, 219, 219);
  static const Color grey = Colors.grey;

  static const Color darkGrey = Color.fromARGB(255, 76, 76, 76);
  static const Color transparent = Colors.transparent;
  static const Color semiTransparent = Colors.black12;
  static const Color spinnerOverlay = Color.fromARGB(28, 216, 216, 216);
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }
}
