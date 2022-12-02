import 'package:flutter/material.dart';
import 'package:flutter_calendar/config/sync_theme.dart';
import 'package:flutter_calendar/wallet/screen/wallet_init_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: SyncTheme.themeData,
      home: const WalletInitScreen(),
    );
  }
}
