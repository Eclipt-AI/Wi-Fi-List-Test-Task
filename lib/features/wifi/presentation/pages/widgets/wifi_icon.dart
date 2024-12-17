import 'package:flutter/material.dart';
import 'package:wifi_List_Test_Task/core/media/app_icons.dart';
import 'package:wifi_List_Test_Task/features/wifi/domain/models/wifi_network.dart';

class WifiIcon extends StatelessWidget {
  final WifiNetwork network;

  const WifiIcon({
    required this.network,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    switch (network.iconIndex) {
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
