import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_core/constant/core_constants.dart';

import 'circle_buttons.dart';

class BackButtonWidget extends StatelessWidget {
  final icon;

  const BackButtonWidget(IconData this.icon, {super.key});
  @override
  Widget build(BuildContext context) {
    return BackBtn(
        onPressed: () {
          context.canPop()
              ? context.pop()
              : context
                  .goNamed(CoreConstants.route_home); // Close button action
        },
        icon: icon);
  }
}


//designed icon

// GestureDetector(
//       onTap: () {
//         context.canPop()
//             ? context.pop()
//             : context.goNamed(Constants.route_home);
//       },
//       child: Container(
//         width: 31,
//         height: 31,
//         child: Stack(
//           children: [
//             Positioned(
//               top: 0,
//               left: 0,
//               child: Container(
//                 width: 31,
//                 height: 31,
//                 decoration: BoxDecoration(
//                   color: context.colorScheme.onPrimary,
//                   borderRadius: BorderRadius.circular(9),
//                 ),
//               ),
//             ),
//             Positioned(
//               top: 6,
//               left: 5,
//               child: Icon(
//                 Icons.chevron_left,
//                 color: AppColors.grey, // Change to the appropriate color
//                 size: 16.0, // Change to the appropriate size
//               ),
//             ),
//           ],
//         ),
//       ),
//     );