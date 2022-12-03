import 'package:flutter/material.dart';
import 'package:flutter_calendar/web3/sync/models/schedules.dart';
import 'package:velocity_x/velocity_x.dart';

class UpcomingWidget extends StatelessWidget {
  final VoidCallback viewAllTap;
  final VoidCallback onUpcomingTap;
  final MeetingSchedules? meetingSchedules;

  const UpcomingWidget({
    required this.viewAllTap,
    required this.onUpcomingTap,
    this.meetingSchedules,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (meetingSchedules == null)
        ? const Offstage()
        : Column(
            children: [
              Row(
                children: [
                  "Upcoming".text.size(26).semiBold.make().p12(),
                  // const Spacer(),
                  // GestureDetector(
                  //   onTap: viewAllTap,
                  //   child: [
                  //     "View all"
                  //         .text
                  //         .size(16)
                  //         .semiBold
                  //         .color(SyncColor.primaryColor)
                  //         .make(),
                  //     2.widthBox,
                  //     const Icon(
                  //       Icons.arrow_forward_rounded,
                  //       color: SyncColor.primaryColor,
                  //     ),
                  //   ].row(),
                  // ).p12(),
                ],
              ),
              GestureDetector(
                onTap: onUpcomingTap,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.white.withOpacity(0.2),
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          meetingSchedules!.schedules.first.title.text
                              .size(18)
                              .semiBold
                              .make(),
                          const Spacer(),
                          const Icon(Icons.more_vert),
                        ],
                      ).p16(),
                      if (meetingSchedules!
                          .schedules.first.description.isNotEmptyAndNotNull)
                        meetingSchedules!.schedules.first.description.text
                            .caption(context)
                            .size(16)
                            .make()
                            .p16(),
                    ],
                  ),
                ).p12(),
              ),
            ],
          );
  }
}
