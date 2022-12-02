import 'package:hive_flutter/hive_flutter.dart';

mixin FrontierHive {
  static Future<void> setupHive() async {
    await Hive.initFlutter();
  }
}
