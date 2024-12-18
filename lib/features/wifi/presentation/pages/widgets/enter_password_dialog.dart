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
  void _onConnect() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          context.l10n.success,
          style: AppTextStyles.refresh,
        ),
        duration: const Duration(seconds: 2),
      ),
    );
    Navigator.of(context).pop(); // Close the dialog after showing success
  }

  final TextEditingController _passwordController = TextEditingController();

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
                  ],
                ),
              ),
              AppTextField(
                controller: _passwordController,
                hintText: context.l10n.password_hint,
                keyboardType: TextInputType.visiblePassword,
                isPassword: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(31.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 4,
                  ),
                ),
                onPressed: _onConnect,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    context.l10n.connect,
                    style: AppTextStyles.refresh,
                  ),
                ),
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
