// ignore_for_file: use_build_context_synchronously

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_calendar/config/sync_theme.dart';
import 'package:flutter_calendar/home/guest/guest_home_page.dart';
import 'package:flutter_calendar/home/host/host_home_page.dart';
import 'package:flutter_calendar/splash_page.dart';
import 'package:flutter_calendar/wallet/screen/wallet_init_screen.dart';
import 'package:flutter_calendar/wallet/wallet_manager.dart';
import 'package:uni_links/uni_links.dart';
import 'package:velocity_x/velocity_x.dart';

final myAppNavigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: myAppNavigatorKey,
      theme: SyncTheme.themeData,
      home: const SplashPage(),
      builder: BotToastInit(),
    );
  }
}
