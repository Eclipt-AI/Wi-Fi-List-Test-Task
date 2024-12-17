import 'package:flutter/material.dart';
import 'package:wifi_List_Test_Task/core/styles/app_text_styles.dart';
import 'package:wifi_List_Test_Task/features/wifi/domain/models/wifi_network.dart';
import 'package:wifi_List_Test_Task/features/wifi/presentation/pages/widgets/enter_password_dialog.dart';
import 'package:wifi_List_Test_Task/features/wifi/presentation/pages/widgets/wifi_icon.dart';

class NetworkItem extends StatelessWidget {
  final WifiNetwork network;

  const NetworkItem({
    required this.network,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: WifiIcon(network: network),
      title: Text(
        network.name,
        style: AppTextStyles.networkItem,
      ),
      onTap: network.isClickable ? () => showPasswordDialog(network.name, context) : null,
      enabled: network.isClickable,
    );
  }
}
