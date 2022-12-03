import 'package:web3dart/web3dart.dart';

class MeetingSchedules {
  final List<Schedule> schedules;

  MeetingSchedules(this.schedules);

  factory MeetingSchedules.fromList(List<dynamic> list) {
    return MeetingSchedules(
      list.map((e) => Schedule.fromList(e)).toList(),
    );
  }
}

class Schedule {
  final String title;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final String host;
  final String quest;
  final bool isCancelled;

  factory Schedule.fromList(List<dynamic> list) {
    final scheduleList = list[0][0];

    return Schedule(
      title: scheduleList[5],
      description: scheduleList[4],
      startTime: DateTime.fromMillisecondsSinceEpoch(scheduleList[1].toInt()),
      endTime: DateTime.fromMillisecondsSinceEpoch(scheduleList[2].toInt()),
      host: (scheduleList.first as EthereumAddress).hex,
      quest: (scheduleList[3].first as EthereumAddress).hex,
      isCancelled: list[0][1] as bool,
    );
  }

  Schedule({
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.host,
    required this.quest,
    required this.isCancelled,
  });
}
