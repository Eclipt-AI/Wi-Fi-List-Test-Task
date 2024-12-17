import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        title: Text(
          context.l10n.connect_to_wifi,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _passwordController,
              obscureText: state.obscurePassword,
              decoration: InputDecoration(
                labelText: context.l10n.password,
                suffixIcon: IconButton(
                  icon: Icon(
                    state.obscurePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () => context.read<WifiOptionsCubit>().togglePasswordVisibility(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _showSuccessMessage(widget.networkName);
              },
              child: Text(context.l10n.connect),
            ),
          ],
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
