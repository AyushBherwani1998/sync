import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar/config/sync_colors.dart';
import 'package:flutter_calendar/constants.dart';
import 'package:flutter_calendar/home/update_name_page.dart';
import 'package:flutter_calendar/home/widgets/user_detail_widget.dart';
import 'package:flutter_calendar/utils/crypto_utils.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:web3dart/web3dart.dart';

class GuestHomePage extends StatefulWidget {
  const GuestHomePage({super.key});

  @override
  State<GuestHomePage> createState() => _GuestHomePageState();
}

class _GuestHomePageState extends State<GuestHomePage> {
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

                    showCupertinoModalPopup(
                      context: context,
                      builder: (BuildContext context) => CupertinoActionSheet(
                        //itle: const Text('Choose Options'),
                        //message: const Text('Your options are '),
                        actions: <Widget>[
                          CupertinoActionSheetAction(
                            child: const Text('Edit Name'),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const UpdateNamePage();
                                  },
                                ),
                              );
                            },
                          ),
                          CupertinoActionSheetAction(
                            child: const Text('View private key'),
                            onPressed: () {
                              Navigator.pop(context);
                              // TODO(someshubham): Go to View Private Key
                            },
                          ),
                          CupertinoActionSheetAction(
                            child: const Text(
                              'Remove account',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              // TODO(someshubham): Clear PK and go to home
                            },
                          )
                        ],
                        cancelButton: CupertinoActionSheetAction(
                          isDefaultAction: true,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                16.heightBox,
                "When do you want to sync with"
                    .text
                    .size(26)
                    .semiBold
                    .make()
                    .pOnly(left: 12, top: 12, bottom: 4),
                Row(
                  children: [
                    "shubham.eth"
                        .text
                        .size(26)
                        .semiBold
                        .textStyle(
                          const TextStyle(
                            decoration: TextDecoration.underline,
                            decorationStyle: TextDecorationStyle.dotted,
                          ),
                        )
                        .make()
                        .pOnly(left: 12, top: 2, bottom: 12),
                    4.widthBox,
                    "?".text.size(22).semiBold.make().pOnly(bottom: 4),
                  ],
                ),
                SfCalendar(
                  view: CalendarView.month,
                  selectionDecoration: BoxDecoration(
                    color: SyncColor.primaryColor.withOpacity(0.2),
                    //border: Border.all(color: const Color(0xff), width: 2),
                    shape: BoxShape.circle,
                  ),
                  monthCellBuilder:
                      (BuildContext buildContext, MonthCellDetails details) {
                    if (details.date.day == DateTime.now().day &&
                        details.date.month == DateTime.now().month) {
                      return Center(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Text(
                              details.date.day.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    }

                    if (details.date.month != DateTime.now().month ||
                        details.date.day < DateTime.now().day) {
                      return Center(
                        child: Text(
                          details.date.day.toString(),
                          style: const TextStyle(color: Colors.white38),
                        ),
                      );
                    }

                    return Center(
                      child: Text(
                        details.date.day.toString(),
                      ),
                    );
                  },
                  initialSelectedDate: DateTime.now(),
                  onTap: (calendarTapDetails) {
                    showModalBottomSheet(
                      context: context,
                      clipBehavior: Clip.antiAlias,
                      isScrollControlled: true,
                      builder: (context) {
                        return DraggableScrollableSheet(
                          expand: false,
                          maxChildSize: 0.75,
                          initialChildSize: 0.49,
                          builder: (context, controller) {
                            return SafeArea(
                              child: Container(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        "Select time to sync"
                                            .text
                                            .size(26)
                                            .semiBold
                                            .make()
                                            .p16(),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ).p16(),
              ],
            );
          }),
    );
  }
}
