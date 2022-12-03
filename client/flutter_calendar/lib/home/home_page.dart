import 'package:flutter/material.dart';
import 'package:flutter_calendar/constants.dart';
import 'package:flutter_calendar/data/models/schedule_model.dart';
import 'package:flutter_calendar/home/widgets/availability_widget.dart';
import 'package:flutter_calendar/home/widgets/upcoming_widget.dart';
import 'package:flutter_calendar/home/widgets/user_detail_widget.dart';
import 'package:flutter_calendar/utils/crypto_utils.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:web3dart/web3dart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: ValueListenableBuilder(
          valueListenable: Hive.box(SyncConstant.privateKeyBox).listenable(),
          builder: (
            context,
            Box privateKeyBox,
            value,
          ) {
            final uintList =
                privateKeyBox.get(SyncConstant.privateKeyStorageKey);
            final key = EthPrivateKey.fromHex(bytesToHex(uintList));
            return Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserDetailWidget(
                  privateKey: key,
                  onAddressTap: () {
                    // TODO(someshubham): Add Address Tap Callback
                  },
                ),
                16.heightBox,
                UpcomingWidget(
                  viewAllTap: () {
                    // Navigate to view all page
                  },
                  onUpcomingTap: () {
                    // Navigate to upcoming tap
                  },
                  scheduleModel: ScheduleModel(
                    address: "0x9878978926",
                    guests: const ["0x2514654"],
                    title: "Ayush <> EthFinalist",
                    description: "7th May   •   9:30 PM   •   30mins",
                    startTime: DateTime.now(),
                    endTime: DateTime.now(),
                  ),
                ),
                10.heightBox,
                AvailabilityWidget(
                  onAddAvailability: () {
                    // TODO(someshubham): Add your availability callback
                  },
                  onShareAvailability: () {
                    // TODO(someshubham): Add your Share callback
                  },
                ),
              ],
            );
          }),
    );
  }
}
