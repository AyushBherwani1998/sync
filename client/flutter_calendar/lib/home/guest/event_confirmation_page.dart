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
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

class EventConfirmationPage extends StatefulWidget {
  final String hash;
  const EventConfirmationPage({
    Key? key,
    required this.hash,
  }) : super(key: key);

  @override
  State<EventConfirmationPage> createState() => _EventConfirmationPageState();
}

class _EventConfirmationPageState extends State<EventConfirmationPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          Lottie.asset(SyncLottie.done, height: 200),
          const Spacer(),
          Row(
            children: [
              "View meeting on blockchain".text.semiBold.size(20).make().p16(),
            ],
          ).onTap(() {
            _launchUrl(widget.hash);
          }),
          24.heightBox,
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

  Future<void> _launchUrl(String hash) async {
    Uri uri = Uri.parse("https://mumbai.polygonscan.com/tx/$hash");
    await launchUrl(uri);
  }
}
