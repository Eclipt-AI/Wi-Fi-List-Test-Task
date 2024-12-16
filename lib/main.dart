import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WLAN Verbindung',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const WifiScreen(),
    );
  }
}

class WifiScreen extends StatefulWidget {
  const WifiScreen({super.key});

  @override
  State<WifiScreen> createState() => _WifiScreenState();
}

class _WifiScreenState extends State<WifiScreen> {
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

    // Simulate network refresh
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        // Shuffle existing networks
        _networks.shuffle();

        // Randomly add a new network
        if (Random().nextBool()) {
          _networks.add({
            'name': 'Neues Netzwerk ${Random().nextInt(100)}',
            'strength': Random().nextInt(4) + 1,
            'isClickable': false,
          });
        }

        _isRefreshing = false;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WLAN Verbindung'),
        actions: [
          IconButton(
            icon: _isRefreshing
                ? const CircularProgressIndicator(color: Colors.white)
                : const Icon(Icons.refresh),
            onPressed: _isRefreshing ? null : _refreshNetworks,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _networks.length,
        itemBuilder: (context, index) {
          final network = _networks[index];
          return ListTile(
            leading: _buildWifiIcon(network['strength']),
            title: Text(network['name']),
            onTap: network['isClickable']
                ? () => _showPasswordDialog(network['name'])
                : null,
            enabled: network['isClickable'],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }
}