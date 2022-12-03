// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_calendar/config/sync_colors.dart';
import 'package:flutter_calendar/constants.dart';
import 'package:flutter_calendar/home/guest/guest_home_page.dart';
import 'package:flutter_calendar/home/host/host_home_page.dart';
import 'package:flutter_calendar/wallet/screen/import_private_key_screen.dart';
import 'package:flutter_calendar/wallet/wallet_manager.dart';
import 'package:flutter_calendar/widgets/sync_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:velocity_x/velocity_x.dart';

class WalletInitScreen extends StatefulWidget {
  const WalletInitScreen({Key? key}) : super(key: key);

  @override
  State<WalletInitScreen> createState() => _WalletInitScreenState();
}

class _WalletInitScreenState extends State<WalletInitScreen> {
  String? hostAddress;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hostAddress =
        Hive.box(SyncConstant.hostAddressBox).get(SyncConstant.hostAddressKey);
  }

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
              child: "Sync".text.size(40).make(),
            ),
          ),
          SyncButton(
            label: "Create new wallet",
            onTap: () async {
              // Create wallet
              await WalletManager().createWallet();

              // Navigate to home page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  if (hostAddress == null) {
                    return const HostHomePage();
                  } else {
                    return const GuestHomePage();
                  }
                }),
              );
            },
          ),
          SyncButton(
            label: "Import wallet",
            textColor: SyncColor.primaryColor,
            bgColor: Colors.white,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return const ImportPrivateKeyScreen();
                }),
              );
            },
          ),
          const Divider().p8(),
          SyncButton(
            label: "Continue with Google",
            icon: const Icon(
              FontAwesomeIcons.google,
              color: SyncColor.primaryColor,
            ),
            textColor: SyncColor.primaryColor,
            bgColor: Colors.white,
            onTap: () {},
          ),
          40.heightBox,
        ],
      ),
    );
  }
}
