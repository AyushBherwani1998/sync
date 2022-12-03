import 'package:flutter_calendar/data/meeting_platform.dart';
import 'package:flutter_calendar/web3/sync/models/sync_event.dart';
import 'package:flutter_calendar/widgets/item_list.dart';

class SyncRawData {
  SyncRawData._();

  static get availabilityList => <Item<String>>[
        Item(
          title: "Everyday",
        ),
        Item(
          title: "All days except weekends",
        ),
        Item(
          title: "Some days",
        ),
      ];

  static get timingList => [
        Item(
          title: "15 mins",
          data: 15,
        ),
        Item(
          title: "30 mins",
          data: 30,
        ),
        Item(
          title: "45 mins",
          data: 45,
        ),
        Item(
          title: "60 mins",
          data: 60,
        ),
      ];

  static get meetingList => [
        Item(
          title: "Google meet",
          data: MeetingPlatform.google,
        ),
        Item(
          title: "Zoom",
          data: MeetingPlatform.zoom,
        ),
        Item(
          title: "Huddle01",
          data: MeetingPlatform.huddle01,
        ),
      ];
}
