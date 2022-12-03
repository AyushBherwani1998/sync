import 'package:equatable/equatable.dart';

class ScheduleModel extends Equatable {
  final DateTime startTime;
  final DateTime endTime;
  final String title;
  final String? description;
  final String address;
  final List<String> guests;

  const ScheduleModel({
    required this.startTime,
    required this.endTime,
    required this.title,
    required this.address,
    required this.guests,
    this.description,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    final startTime =
        DateTime.fromMillisecondsSinceEpoch(json["start_timestamp"] * 1000);
    final endTime =
        DateTime.fromMillisecondsSinceEpoch(json["end_timestamp"] * 1000);
    return ScheduleModel(
      startTime: startTime,
      endTime: endTime,
      title: json["title"],
      address: json["address"],
      guests: json["guests"] ?? <String>[],
    );
  }

  @override
  List<Object?> get props => [
        startTime,
        endTime,
        title,
        address,
        guests,
      ];
}
