import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:ui_core/constant/core_colors.dart';

import '../Extension.dart';

Widget get lineAnimation => Container(
      height: 3.scalablePixel,
      color: CoreColors.grey,
      margin: EdgeInsets.symmetric(vertical: 16.scalablePixel),
    ).animate().scale(duration: 600.ms, alignment: Alignment.centerLeft);

Widget get lineAnimationSmall => Container(
      height: 3.scalablePixel,
      color: CoreColors.grey,
      margin: EdgeInsets.symmetric(vertical: 5.scalablePixel),
    ).animate().scale(duration: 700.ms, alignment: Alignment.centerLeft);
