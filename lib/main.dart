import 'package:flutter/material.dart';
import 'package:wifi_List_Test_Task/app.dart';
import 'package:wifi_List_Test_Task/injection/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await getIt.allReady();
  runApp(const App());
}
