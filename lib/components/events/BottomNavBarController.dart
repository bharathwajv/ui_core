import 'package:flutter/material.dart';

class BottomNavBarController {
  static final BottomNavBarController _instance =
      BottomNavBarController._internal();

  final ValueNotifier<bool> _isVisible = ValueNotifier<bool>(true);

  factory BottomNavBarController() {
    return _instance;
  }

  BottomNavBarController._internal();

  ValueNotifier<bool> get isVisible => _isVisible;

  void hide() {
    _isVisible.value = false;
  }

  void show() {
    _isVisible.value = true;
  }

  void toggle() {
    _isVisible.value = !_isVisible.value;
  }
}
