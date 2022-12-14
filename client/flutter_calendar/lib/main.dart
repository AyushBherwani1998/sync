import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_calendar/app.dart';
import 'package:flutter_calendar/constants.dart';
import 'package:flutter_calendar/data/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uni_links/uni_links.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FrontierHive.setupHive();

  await Hive.openBox(SyncConstant.privateKeyBox);
  await Hive.openBox(SyncConstant.userNameBox);
  await Hive.openBox(SyncConstant.hostAddressBox);
  runZonedGuarded(() {
    runApp(const MyApp());
  }, (error, stackTrace) {
    print(stackTrace);
  });

  
}
