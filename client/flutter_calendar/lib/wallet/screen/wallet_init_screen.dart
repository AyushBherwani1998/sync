import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_calendar/config/sync_colors.dart';
import 'package:flutter_calendar/home/host_home_page.dart';
import 'package:flutter_calendar/wallet/screen/import_private_key_screen.dart';
import 'package:flutter_calendar/wallet/wallet_manager.dart';
import 'package:flutter_calendar/widgets/sync_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:web3auth_flutter/enums.dart';
import 'package:web3auth_flutter/input.dart';
import 'package:web3auth_flutter/output.dart';
import 'package:web3auth_flutter/web3auth_flutter.dart';

class WalletInitScreen extends StatefulWidget {
  const WalletInitScreen({Key? key}) : super(key: key);

  @override
  State<WalletInitScreen> createState() => _WalletInitScreenState();
}

class _WalletInitScreenState extends State<WalletInitScreen> {

  String _result = '';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    HashMap themeMap = HashMap<String, String>();
    themeMap['primary'] = "#229954";

    Uri redirectUrl;
    if (Platform.isAndroid) {
      redirectUrl = Uri.parse('w3a://com.flutter.sync.flutter_calendar/auth');
    } else if (Platform.isIOS) {
      redirectUrl = Uri.parse('io.flutter.flutter.app://openlogin');
    } else {
      throw UnKnownException('Unknown platform');
    }

    await Web3AuthFlutter.init(Web3AuthOptions(
        clientId: 'BN45-V-mSBoMGddLJIdubOEndvnR-14R20nJNICEy7Qqad6G7hKREhTxiQahm8z44JXIv_GSFeU6DsnUs5UWmNA',
        network: Network.mainnet,
        redirectUrl: redirectUrl,
        whiteLabel: WhiteLabelData(
            dark: true, name: "Web3Auth Flutter App", theme: themeMap)));
  }

  VoidCallback _login(Future<Web3AuthResponse> Function() method) {
    return () async {
      try {
        final Web3AuthResponse response = await method();
        setState(() {
          _result = response.toString();
          print("check"+_result);
        });
      } on UserCancelledException {
        print("User cancelled.");
      } on UnKnownException {
        print("Unknown exception occurred");
      }
    };
  }

  Future<Web3AuthResponse> _withGoogle() {
    return Web3AuthFlutter.login(LoginParams(
      loginProvider: Provider.google
    ));
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
                  return const HostHomePage();
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
            onTap: _login(_withGoogle),
          ),
          40.heightBox,
        ],
      ),
    );
  }
}
