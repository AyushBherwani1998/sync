

import 'package:flutter_calendar/constants.dart';

mixin ShareHelper {

  void callShare(String address) {
    String iosLink = SyncConstant.iosAppendLink+address;
    String androidLink = SyncConstant.androidAppendLink+address;
    //todo show share link with ios and Android
  }
  
}