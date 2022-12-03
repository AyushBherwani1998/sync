import 'package:flutter/material.dart';
import 'package:flutter_calendar/config/sync_lottie.dart';
import 'package:flutter_calendar/constants.dart';
import 'package:flutter_calendar/home/host/host_home_page.dart';
import 'package:flutter_calendar/utils/crypto_utils.dart';
import 'package:flutter_calendar/web3/sync/models/sync_event.dart';
import 'package:flutter_calendar/widgets/sync_button.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

class MeetingConfirmationPage extends StatefulWidget {
  final DateTime dateTime;
  final SyncEvent event;
  final String title;

  const MeetingConfirmationPage({
    Key? key,
    required this.dateTime,
    required this.event,
    required this.title,
  }) : super(key: key);

  @override
  State<MeetingConfirmationPage> createState() =>
      _MeetingConfirmationPageState();
}

class _MeetingConfirmationPageState extends State<MeetingConfirmationPage> {
  late String hostAddress;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hostAddress =
        Hive.box(SyncConstant.hostAddressBox).get(SyncConstant.hostAddressKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          52.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(SyncLottie.done, height: 200),
            ],
          ),
          Row(
            children: [
              Expanded(
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
                      widget.title.text.semiBold.size(24).make().p12(),
                      "with ${hostAddress.toString().addressAbbreviation}"
                          .text
                          .caption(context)
                          .size(16)
                          .make()
                          .pOnly(
                            left: 12,
                            top: 12,
                            bottom: 12,
                          ),
                      "${DateFormat('MMMd').format(widget.dateTime)}   •   ${DateFormat('jm').format(widget.dateTime)}   •   ${widget.event.timeSlot}mins"
                          .text
                          .size(20)
                          .semiBold
                          .caption(context)
                          .make()
                          .p12(),
                    ],
                  ),
                ).p12(),
              ),
            ],
          ),
          Row(
            children: [
              "View meeting on blockchain".text.semiBold.size(20).make().p16(),
            ],
          ),
          const Spacer(),
          SyncButton(
            label: "Go to home",
            onTap: () {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                builder: (context) {
                  Hive.box(SyncConstant.hostAddressBox).clear();
                  return const HostHomePage();
                },
              ), (route) => false);
            },
          ),
          40.heightBox,
        ],
      ),
    );
  }
}
