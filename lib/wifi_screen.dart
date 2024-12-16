import 'dart:math';

import 'package:flutter/material.dart';

class WifiScreen extends StatefulWidget {
  const WifiScreen({super.key});

  @override
  State<WifiScreen> createState() => _WifiScreenState();
}

class _WifiScreenState extends State<WifiScreen> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  // Initial list of WiFi networks
  final List<Map<String, dynamic>> _initialNetworks = [
    {'name': 'Workspace-WLAN', 'strength': 4, 'isClickable': true},
    {'name': 'XYZ-WLAN', 'strength': 3, 'isClickable': true},
    {'name': 'Freifunk', 'strength': 2, 'isClickable': false},
    {'name': 'Telekom_FON', 'strength': 4, 'isClickable': false},
    {'name': 'FRITZ!Box 7590', 'strength': 3, 'isClickable': false},
    {'name': 'Vodafone Hotspot', 'strength': 2, 'isClickable': false},
  ];

  late List<Map<String, dynamic>> _networks;
  bool _isRefreshing = false;
  String? _selectedNetwork;
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _networks = List.from(_initialNetworks);
  }
  void _refreshNetworks() {
    setState(() {
      _isRefreshing = true;
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        // Notify AnimatedList to remove all current items
        for (int i = _networks.length - 1; i >= 0; i--) {
          final removedItem = _networks.removeAt(i);
          _listKey.currentState!.removeItem(
            i,
                (context, animation) => _buildNetworkItem(removedItem, i, animation),
          );
        }
      });

      // Simulate network refresh with a delay
      Future.delayed(const Duration(milliseconds: 300), () {
        setState(() {
          // Shuffle the initial networks and optionally add a new one
          _networks = List.from(_initialNetworks)..shuffle();
          if (Random().nextBool()) {
            final newNetwork = {
              'name': 'Neues Netzwerk ${Random().nextInt(100)}',
              'strength': Random().nextInt(4) + 1,
              'isClickable': false,
            };
            _networks.add(newNetwork);
          }

          // Notify AnimatedList to insert the new items
          for (int i = 0; i < _networks.length; i++) {
            _listKey.currentState!.insertItem(i);
          }

          _isRefreshing = false;
        });
      });
    });
  }


  void _showPasswordDialog(String networkName) {
    setState(() {
      _selectedNetwork = networkName;
      _passwordController.clear();
    });

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text('Verbinden mit $networkName'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Passwort',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _showSuccessMessage();
                },
                child: const Text('Verbinden'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSuccessMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Erfolgreich mit $_selectedNetwork verbunden!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  Widget _buildWifiIcon(int strength) {
    IconData icon;
    switch (strength) {
      case 4:
        icon = Icons.signal_wifi_4_bar;
        break;
      case 3:
        icon = Icons.signal_wifi_4_bar;
        break;
      case 2:
        icon = Icons.signal_wifi_4_bar;
        break;
      default:
        icon = Icons.signal_wifi_4_bar;
    }
    return Icon(icon);
  }

  Widget _buildNetworkItem(Map<String, dynamic> network, int index, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: ListTile(
        leading: _buildWifiIcon(network['strength']),
        title: Text(network['name']),
        onTap: network['isClickable'] ? () => _showPasswordDialog(network['name']) : null,
        enabled: network['isClickable'],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Willkommen!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Lass uns beginnen indem wir uns mit einem WLAN verbinden.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              AnimatedList(
                key: _listKey,
                initialItemCount: _networks.length,
                shrinkWrap: true,
                itemBuilder: (context, index, animation) {
                  final network = _networks[index];
                  return _buildNetworkItem(network, index, animation);
                },
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    onPressed: _isRefreshing ? null : _refreshNetworks,
                    icon: _isRefreshing
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Icon(
                            Icons.refresh,
                            color: Colors.white,
                          ),
                    label: Text(
                      _isRefreshing ? 'Laden...' : 'Neu Laden',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }
}
