import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:wifi_List_Test_Task/core/styles/app_theme.dart';
import 'package:wifi_List_Test_Task/features/wifi/presentation/bloc/wifi_options_cubit/wifi_options_cubit.dart';
import 'package:wifi_List_Test_Task/features/wifi/presentation/pages/wifi_screen.dart';
import 'package:wifi_List_Test_Task/injection/injection.dart';
import 'package:wifi_List_Test_Task/l10n/l10n.dart';

part 'providers.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  bool isOrientationsSet = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setPreferredOrientations(context);
  }

  void setPreferredOrientations(BuildContext context) {
    if(isOrientationsSet) return;
    isOrientationsSet = true;

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: providers,
      child:  MaterialApp(
        theme: AppTheme.main,
        locale: const Locale('de'),
        supportedLocales: const [Locale('de')],
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: const WifiScreen(),
      ),
    );
  }
}
