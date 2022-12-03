enum MeetingPlatform { google, zoom, huddle01 }

extension X on MeetingPlatform {
  String? get provider => {
        MeetingPlatform.google: "Google",
        MeetingPlatform.zoom: "Zoom",
        MeetingPlatform.huddle01: "Huddle01",
      }[this];
}
