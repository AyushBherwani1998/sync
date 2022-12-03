import 'package:flutter/material.dart';
import 'package:flutter_calendar/config/images.dart';
import 'package:flutter_calendar/config/sync_colors.dart';
import 'package:flutter_calendar/data/meeting_platform.dart';
import 'package:flutter_calendar/web3/sync/models/sync_event.dart';
import 'package:flutter_calendar/widgets/sync_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:velocity_x/velocity_x.dart';

class AvailabilityWidget extends StatelessWidget {
  final VoidCallback onAddAvailability;
  final VoidCallback onShareAvailability;
  final bool isAlreadyAvailable;
  final SyncEvent? syncEvent;

  const AvailabilityWidget({
    required this.onAddAvailability,
    required this.onShareAvailability,
    this.isAlreadyAvailable = true,
    this.syncEvent,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        "Your availability".text.size(26).semiBold.make().p12(),
        16.heightBox,
        (isAlreadyAvailable)
            ? GestureDetector(
                onTap: onShareAvailability,
                child: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.white.withOpacity(0.2),
                      ),
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xff181818),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "${syncEvent!.timeSlot.toString()} min"
                            .text
                            .size(28)
                            .bold
                            .make()
                            .pOnly(
                              top: 20,
                              left: 16,
                            ),
                        Row(
                          children: [
                            "All days in a week"
                                .text
                                .caption(context)
                                .size(20)
                                .make(),
                            const Spacer(),
                            const CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 12,
                            ),
                            8.widthBox,
                            syncEvent!.meetingPlatform.provider!.text
                                .size(18)
                                .make(),
                          ],
                        ).p16(),
                      ],
                    ),
                  ).p12(),
                  SyncButton(
                    label: "Share",
                    onTap: () {
                      // TODO(someshubham): Add Share Functionality
                    },
                  ),
                ].column(),
              )
            : GestureDetector(
                onTap: onAddAvailability,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    [
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              style: TextButton.styleFrom(
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 28,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {},
                              child: "Everyday"
                                  .text
                                  .size(16)
                                  .color(Colors.white.withOpacity(0.8))
                                  .make(),
                            ).p8(),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              style: TextButton.styleFrom(
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 28,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {},
                              child: "All days except weekends"
                                  .text
                                  .size(16)
                                  .color(Colors.white.withOpacity(0.8))
                                  .make(),
                            ).p8(),
                          ),
                        ],
                      ),
                    ].column(),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            SyncColor.syncBlack.withOpacity(0.7),
                            SyncColor.syncBlack,
                          ],
                        ),
                      ),
                      height: 54,
                    ),
                    Column(
                      children: [
                        SvgPicture.asset(SyncImage.availabilitySvg),
                        12.heightBox,
                        TextButton(
                          onPressed: () {},
                          child: "Add your availability"
                              .text
                              .size(20)
                              .semiBold
                              .make(),
                        ),
                      ],
                    ),
                  ],
                ),
              )
      ],
    );
  }
}
