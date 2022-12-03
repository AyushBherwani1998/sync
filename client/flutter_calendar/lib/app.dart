import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar/config/sync_theme.dart';
import 'package:flutter_calendar/home/guest_home_page.dart';
import 'package:flutter_calendar/home/host_home_page.dart';
import 'package:flutter_calendar/wallet/screen/wallet_init_screen.dart';
import 'package:flutter_calendar/wallet/wallet_manager.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final isFirstTimeUser = WalletManager().isFirstTimeUser();
    return MaterialApp(
      theme: SyncTheme.themeData,
      home: isFirstTimeUser ? const WalletInitScreen() : const HostHomePage(),
      builder: BotToastInit(),
    );
  }
}
