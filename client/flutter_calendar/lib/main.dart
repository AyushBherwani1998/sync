import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_calendar/app.dart';
import 'package:flutter_calendar/constants.dart';
import 'package:flutter_calendar/data/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:web3auth_flutter/enums.dart';
import 'package:web3auth_flutter/input.dart';
import 'package:web3auth_flutter/web3auth_flutter.dart';


import 'dart:io' show Platform;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FrontierHive.setupHive();

  await Hive.openBox(SyncConstant.privateKeyBox);
  runZonedGuarded(() {
    runApp(const MyApp());
  }, (error, stackTrace) {
    print(stackTrace);
  });

  Uri redirectUrl;
  if (Platform.isAndroid) {
    redirectUrl = Uri.parse('${SyncConstant.androidScheme}://${SyncConstant.androidHost}/auth');
  } else {
    redirectUrl = Uri.parse('${SyncConstant.iOSBundleId}://openlogin');
  }


  await Web3AuthFlutter.init(Web3AuthOptions(
    clientId: SyncConstant.web3AuthClient,
    network: Network.mainnet,
    redirectUrl: Uri.parse('com.example.flutter_calendar://auth')
    ));
  
}
