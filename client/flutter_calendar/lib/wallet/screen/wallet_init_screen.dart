import 'package:flutter/material.dart';
import 'package:flutter_calendar/config/sync_colors.dart';
import 'package:flutter_calendar/wallet/screen/import_private_key_screen.dart';
import 'package:flutter_calendar/widgets/sync_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:web3auth_flutter/web3auth_flutter.dart';

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
              child: "Sync".text.size(40).make(),
            ),
          ),
          SyncButton(
            label: "Create new wallet",
            onTap: () {},
            icon: const Icon(Icons.create),
          ),
          SyncButton(
            label: "Import wallet",
            icon: const Icon(
              Icons.import_export_sharp,
              color: SyncColor.primaryColor,
            ),
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
            onTap: () async {
              final Web3AuthResponse response = await Web3AuthFlutter.login(provider:Provider.google);
                print(response.privKey);
            },
          ),
          40.heightBox,
        ],
      ),
    );
  }
}
