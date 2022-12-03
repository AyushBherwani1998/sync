import 'package:flutter/material.dart';
import 'package:flutter_calendar/config/images.dart';
import 'package:flutter_calendar/config/sync_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:velocity_x/velocity_x.dart';

class AvailabilityWidget extends StatelessWidget {
  final VoidCallback onTap;

  const AvailabilityWidget({
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          "Your availability".text.size(26).semiBold.make().p12(),
          16.heightBox,
          Stack(
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
                    child:
                        "Add your availability".text.size(20).semiBold.make(),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
