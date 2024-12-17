import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wifi_List_Test_Task/features/wifi/domain/models/wifi_network.dart';
import 'package:wifi_List_Test_Task/features/wifi/presentation/bloc/wifi_options_cubit/wifi_options_cubit.dart';
import 'package:wifi_List_Test_Task/features/wifi/presentation/pages/widgets/wifi_icon.dart';

class NetworkItem extends StatefulWidget {
  final WifiNetwork network;
  final Animation<double> animation;

  const NetworkItem({
    required this.network,
    required this.animation,
    super.key,
  });

  @override
  State<NetworkItem> createState() => _NetworkItemState();
}

class _NetworkItemState extends State<NetworkItem> {
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _showSuccessMessage(String networkName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Erfolgreich mit $networkName verbunden!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showPasswordDialog(String networkName) {
    final cubit = context.read<WifiOptionsCubit>();
    cubit.selectNetwork(networkName);
    _passwordController.clear();

    showDialog(
      context: context,
      builder: (context) => BlocBuilder<WifiOptionsCubit, WifiOptionsState>(
        builder: (context, state) => AlertDialog(
          title: Text('Verbinden mit $networkName'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _passwordController,
                obscureText: state.obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Passwort',
                  suffixIcon: IconButton(
                    icon: Icon(
                      state.obscurePassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () => cubit.togglePasswordVisibility(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _showSuccessMessage(networkName);
                },
                child: const Text('Verbinden'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: widget.animation,
      child: ListTile(
        leading: WifiIcon(network: widget.network),
        title: Text(widget.network.name),
        onTap: widget.network.isClickable ? () => _showPasswordDialog(widget.network.name) : null,
        enabled: widget.network.isClickable,
      ),
    );
  }
}
