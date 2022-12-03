import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_calendar/app.dart';
import 'package:flutter_calendar/constants.dart';
import 'package:flutter_calendar/data/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uni_links/uni_links.dart';
import 'package:flutter/services.dart' show PlatformException;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FrontierHive.setupHive();

  await Hive.openBox(SyncConstant.privateKeyBox);
  await Hive.openBox(SyncConstant.userNameBox);
  runZonedGuarded(() {
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
