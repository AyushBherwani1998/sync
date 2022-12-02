import 'package:flutter/material.dart';
import 'package:flutter_calendar/config/sync_colors.dart';
import 'package:flutter_calendar/widgets/sync_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

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
          Expanded(
            child: Center(
              child: "Sync".text.size(48).bold.make(),
            ),
          ),
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
          const Divider().p8(),
          SyncButton(
            label: "Google Sign In",
            icon: const Icon(
              FontAwesomeIcons.google,
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
