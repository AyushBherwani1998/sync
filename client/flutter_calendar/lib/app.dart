import 'package:flutter/material.dart';
import 'package:flutter_calendar/wallet/screen/wallet_create_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WalletCreateScreen(),
    );
  }
}
