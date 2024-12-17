import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wifi_List_Test_Task/core/media/app_icons.dart';

class WifiIcon extends StatelessWidget {
  const WifiIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final option = Random().nextInt(4);
    switch (option) {
      case 0:
        return Image.asset(
          AppIcons.wifiSignalLocked1,
          width: 49,
          height: 39,
        );
      case 1:
        return Image.asset(
          AppIcons.wifiSignalLocked2,
          width: 49,
          height: 39,
        );
      case 2:
        return Image.asset(
          AppIcons.wifiSignal3,
          width: 49,
          height: 39,
        );
      case 3:
        return Image.asset(
          AppIcons.wifiSignal2,
          width: 49,
          height: 39,
        );
      default:
        return Image.asset(
          AppIcons.wifiSignal3,
          width: 49,
          height: 39,
        );
    }
  }
}
