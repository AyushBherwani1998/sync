import 'package:flutter/material.dart';
import 'package:flutter_calendar/config/sync_colors.dart';
import 'package:flutter_calendar/widgets/sync_button.dart';

class WalletInitScreen extends StatefulWidget {
  const WalletInitScreen({Key? key}) : super(key: key);

  @override
  State<WalletInitScreen> createState() => _WalletInitScreenState();
}

class _WalletInitScreenState extends State<WalletInitScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SyncButton(
            label: "Create Wallet",
            onTap: () {},
            icon: const Icon(Icons.create),
          ),
          SyncButton(
            label: "Import Wallet",
            icon: const Icon(
              Icons.import_export_sharp,
              color: SyncColor.primaryColor,
            ),
            textColor: SyncColor.primaryColor,
            bgColor: Colors.white,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
