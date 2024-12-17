import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wifi_List_Test_Task/core/styles/app_text_styles.dart';
import 'package:wifi_List_Test_Task/core/widgets/app_text_field.dart';
import 'package:wifi_List_Test_Task/features/wifi/presentation/bloc/wifi_options_cubit/wifi_options_cubit.dart';
import 'package:wifi_List_Test_Task/l10n/l10n.dart';

class EnterPasswordDialog extends StatefulWidget {
  final String networkName;

  const EnterPasswordDialog({
    required this.networkName,
    super.key,
  });

  @override
  State<EnterPasswordDialog> createState() => _EnterPasswordDialogState();
}

class _EnterPasswordDialogState extends State<EnterPasswordDialog> {
  final TextEditingController _passwordController = TextEditingController();

  void _showSuccessMessage(String networkName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Erfolgreich mit $networkName verbunden!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WifiOptionsCubit, WifiOptionsState>(
      builder: (context, state) => AlertDialog(
        title: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 20,
          ),
          child: Text(
            context.l10n.connect_to_wifi,
            style: AppTextStyles.dialogTitle,
          ),
        ),
        content: SizedBox(
          width: 1320,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${context.l10n.the_device_is_trying_to_connect_to}${widget.networkName}",
                      style: AppTextStyles.dialogSubtitle,
                    ),
                    Text(
                      context.l10n.please_enter_your_network_password_here,
                      style: AppTextStyles.dialogSubtitle,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      context.l10n.password,
                      style: AppTextStyles.dialogTitle,
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
              AppTextField(
                controller: _passwordController,
                hintText: context.l10n.password_hint,
                keyboardType: TextInputType.visiblePassword,
                isPassword: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showPasswordDialog(String networkName, BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => EnterPasswordDialog(networkName: networkName),
  );
}
