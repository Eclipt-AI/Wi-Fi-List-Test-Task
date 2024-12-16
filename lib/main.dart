import 'package:flutter/material.dart';
import 'dart:math';

import 'package:wifi_List_Test_Task/wifi_screen.dart';

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
