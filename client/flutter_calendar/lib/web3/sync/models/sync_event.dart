import 'package:flutter_calendar/data/meeting_platform.dart';

class SyncEvent {
  String title;
  int timeSlot;
  MeetingPlatform meetingPlatform;

  bool get isEventAvailable => title.isNotEmpty;

  SyncEvent({
    required this.title,
    required this.timeSlot,
    required this.meetingPlatform,
  });

  factory SyncEvent.fromList(List list) {
    return SyncEvent(
      title: list.first,
      timeSlot: list[1].toInt(),
      meetingPlatform: MeetingPlatform.values[list.last.toInt()],
    );
  }
}

