import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wifi_List_Test_Task/core/styles/app_text_styles.dart';
import 'package:wifi_List_Test_Task/features/wifi/domain/models/wifi_network.dart';
import 'package:wifi_List_Test_Task/features/wifi/presentation/bloc/wifi_options_cubit/wifi_options_cubit.dart';
import 'package:wifi_List_Test_Task/features/wifi/presentation/pages/widgets/enter_password_dialog.dart';
import 'package:wifi_List_Test_Task/features/wifi/presentation/pages/widgets/wifi_icon.dart';
import 'package:wifi_List_Test_Task/l10n/l10n.dart';

class NetworkItem extends StatelessWidget {
  final WifiNetwork network;
  final Animation<double> animation;

  const NetworkItem({
    required this.network,
    required this.animation,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: animation,
      child: ListTile(
        leading: WifiIcon(network: network),
        title: Text(
          network.name,
          style: AppTextStyles.networkItem,
        ),
        onTap: network.isClickable ? () => showPasswordDialog(network.name, context) : null,
        enabled: network.isClickable,
      ),
    );
  }
}
