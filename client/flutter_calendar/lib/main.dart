import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_calendar/app.dart';
import 'package:flutter_calendar/data/hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FrontierHive.setupHive();

  runZonedGuarded(() {
    runApp(const MyApp());
  }, (error, stackTrace) {
    print(stackTrace);
  });
}
