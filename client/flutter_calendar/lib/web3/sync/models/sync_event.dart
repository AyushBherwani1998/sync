class SyncEvent {
  String title;
  DateTime timeSlot;
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
      timeSlot: DateTime.fromMillisecondsSinceEpoch(list[1].toInt()),
      meetingPlatform: MeetingPlatform.values[list.last.toInt()],
    );
  }
}

enum MeetingPlatform { google, zoom, huddle01 }
