import 'package:flutter/material.dart';

class CoreIcons {
  static Widget getIcon(String iconName) {
    switch (iconName.toLowerCase()) {
      case 'home':
        return const Icon(Icons.home);
      case 'home_outlined':
        return const Icon(Icons.home_outlined);
      default:
        // IconData? icon = _getIconFromString(iconName);
        return const Icon(Icons.error);
    }
  }

  // static IconData? _getIconFromString(String iconName) {
  //   try {
  //     return IconData(iconName.codeUnitAt(0), fontFamily: 'MaterialIcons');
  //   } catch (e) {
  //     return null;
  //   }
  // }
}
