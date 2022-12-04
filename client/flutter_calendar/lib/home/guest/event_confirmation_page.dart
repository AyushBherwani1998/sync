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

class EventConfirmationPage extends StatefulWidget {
  const EventConfirmationPage({
    Key? key,
  }) : super(key: key);

  @override
  State<EventConfirmationPage> createState() => _EventConfirmationPageState();
}

class _EventConfirmationPageState extends State<EventConfirmationPage> {
  late String hostAddress;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const Spacer(),
          Lottie.asset(SyncLottie.done, height: 200),
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
