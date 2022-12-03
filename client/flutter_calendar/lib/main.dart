import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_calendar/app.dart';
import 'package:flutter_calendar/constants.dart';
import 'package:flutter_calendar/data/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uni_links/uni_links.dart';
import 'package:flutter/services.dart' show PlatformException;
import 'package:web3auth_flutter/enums.dart';
import 'package:web3auth_flutter/input.dart';
import 'package:web3auth_flutter/web3auth_flutter.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FrontierHive.setupHive();

  await Hive.openBox(SyncConstant.privateKeyBox);
  await Hive.openBox(SyncConstant.userNameBox);
  runZonedGuarded(() async {
    Uri redirectUrl;
    if (Platform.isAndroid) {
      redirectUrl = Uri.parse('{SCHEME}://{HOST}/auth');
      // w3a://com.example.w3aflutter/auth
    } else if (Platform.isIOS) {
      redirectUrl = Uri.parse('{bundleId}://openlogin');
      // com.example.w3aflutter://openlogin
    } else {
      throw UnKnownException('Unknown platform');
    }

    await Web3AuthFlutter.init(Web3AuthOptions(
        clientId: 'BN45-V-mSBoMGddLJIdubOEndvnR-14R20nJNICEy7Qqad6G7hKREhTxiQahm8z44JXIv_GSFeU6DsnUs5UWmNA',
        network: Network.mainnet,
        redirectUrl: redirectUrl
    ));
    runApp(const MyApp());
  }, (error, stackTrace) {
    print(stackTrace);
  });

  try {

    final initialLink = await getInitialLink();
    print("Initial URI: $initialLink");

  } on PlatformException {
    //handle error
  }

  linkStream.listen((String? data) {
    print('got uri: $data');
    final address = data!.split("=")[1];
    //navigate to this address
    print("Session Link address: $address");
  }, onError: (Object err) {
    print('got err: $err');
  });

}
