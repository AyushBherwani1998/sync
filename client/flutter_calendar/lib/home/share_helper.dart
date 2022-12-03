import 'package:flutter_calendar/constants.dart';
import 'package:flutter_calendar/web3/sync/models/sync_event.dart';
import 'package:share_plus/share_plus.dart';

mixin ShareHelper {
  void callShare(String address, SyncEvent syncEvent) {
    String iosLink = SyncConstant.iosAppendLink + address;
    String androidLink = SyncConstant.androidAppendLink + address;
    //todo show share link with ios and Android

    final sharingLink =
        "Here is my Availability\niOS: $iosLink\nAndroid: $androidLink";
    Share.share(sharingLink);
  }
}
