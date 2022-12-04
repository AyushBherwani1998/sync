import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar/constants.dart';
import 'package:flutter_calendar/data/meeting_platform.dart';
import 'package:flutter_calendar/data/models/schedule_model.dart';
import 'package:flutter_calendar/data/sync_raw_data.dart';
import 'package:flutter_calendar/home/guest/event_confirmation_page.dart';
import 'package:flutter_calendar/home/guest/event_loading_page.dart';
import 'package:flutter_calendar/home/guest/meeting_loading_page.dart';
import 'package:flutter_calendar/home/share_helper.dart';
import 'package:flutter_calendar/home/update_name_page.dart';
import 'package:flutter_calendar/home/widgets/availability_widget.dart';
import 'package:flutter_calendar/home/widgets/upcoming_widget.dart';
import 'package:flutter_calendar/home/widgets/user_detail_widget.dart';
import 'package:flutter_calendar/utils/crypto_utils.dart';
import 'package:flutter_calendar/web3/sync/models/schedules.dart';
import 'package:flutter_calendar/wallet/screen/wallet_init_screen.dart';
import 'package:flutter_calendar/wallet/wallet_manager.dart';
import 'package:flutter_calendar/web3/sync/models/sync_event.dart';
import 'package:flutter_calendar/web3/sync/sync_contract.dart';
import 'package:flutter_calendar/widgets/item_list.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:web3dart/web3dart.dart';

class HostHomePage extends StatefulWidget {
  const HostHomePage({super.key});

  @override
  State<HostHomePage> createState() => _HostHomePageState();
}

class _HostHomePageState extends State<HostHomePage>
    with SyncContract, ShareHelper {
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
            return ListView(
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
                              WalletManager().removeAccount();
                              Navigator.pop(context);
                              context.nextReplacementPage(
                                const WalletInitScreen(),
                              );
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
                FutureBuilder<MeetingSchedules?>(
                    future: SyncContract.fetchSchedules(key.address.hex),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return UpcomingWidget(
                          viewAllTap: () {},
                          onUpcomingTap: () {},
                          meetingSchedules: MeetingSchedules(
                            [
                              Schedule(
                                title: "---------------",
                                description: "--------------",
                                startTime: DateTime.now(),
                                endTime: DateTime.now(),
                                host: "---------------",
                                quest: "--------------",
                                isCancelled: false,
                              ),
                            ],
                          ),
                        ).shimmer();
                      }
                      return UpcomingWidget(
                        viewAllTap: () {
                          // Navigate to view all page
                        },
                        onUpcomingTap: () {
                          //
                          showCupertinoModalPopup(
                            context: context,
                            builder: (BuildContext context) =>
                                CupertinoActionSheet(
                              //itle: const Text('Choose Options'),
                              //message: const Text('Your options are '),
                              actions: <Widget>[
                                CupertinoActionSheetAction(
                                  child: const Text('Join Huddle01'),
                                  onPressed: () {
                                    _launchUrl();
                                    Navigator.pop(context);
                                  },
                                ),
                                CupertinoActionSheetAction(
                                  child: const Text('Chat with 0x123...4df3'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    // TODO(someshubham): Chat with Host
                                  },
                                ),
                                CupertinoActionSheetAction(
                                  child: const Text(
                                    'Cancel Meeting',
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    // TODO(someshubham): Cancel Meeting
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
                        meetingSchedules:
                            snapshot.hasData ? snapshot.data : null,
                      );
                    }),
                10.heightBox,
                FutureBuilder<SyncEvent?>(
                    future: SyncContract.fetchEvent(key.address.hex),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return [
                          "Your availability"
                              .text
                              .size(26)
                              .semiBold
                              .make()
                              .p12(),
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
                                "00.00 min"
                                    .text
                                    .size(28)
                                    .bold
                                    .make()
                                    .shimmer()
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
                                    "Meeting platform"
                                        .text
                                        .size(18)
                                        .make()
                                        .shimmer(),
                                  ],
                                ).p16(),
                              ],
                            ),
                          ).p12()
                        ].column(crossAlignment: CrossAxisAlignment.start);
                      }

                      return AvailabilityWidget(
                        syncEvent: snapshot.hasData ? snapshot.data : null,
                        isAlreadyAvailable: snapshot.hasData,
                        onAddAvailability: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ItemList<String>(
                                  itemList: SyncRawData.availabilityList,
                                  title: "Select your availability",
                                  onItemSelect: (_) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return ItemList<int>(
                                            itemList: SyncRawData.timingList,
                                            title: "Choose sync duration",
                                            onItemSelect: (time) {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return ItemList<
                                                        MeetingPlatform>(
                                                      itemList: SyncRawData
                                                          .meetingList,
                                                      title:
                                                          "How you wanna sync?",
                                                      onItemSelect:
                                                          (meeting) async {
                                                        if (time.data != null &&
                                                            meeting.data !=
                                                                null) {
                                                          final txHash =
                                                              await SyncContract
                                                                  .addEvent(
                                                            time.data!,
                                                            meeting.data!,
                                                          );

                                                          // ignore: use_build_context_synchronously
                                                          context.nextPage(
                                                            EventLoadingPage(
                                                              onSuccess:
                                                                  (context) {
                                                                context
                                                                    .nextReplacementPage(
                                                                  const EventConfirmationPage(),
                                                                );
                                                              },
                                                              onFailure:
                                                                  (context) {
                                                                context.pop();
                                                              },
                                                              hash: txHash!,
                                                            ),
                                                          );
                                                        }
                                                      },
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          );
                        },
                        onShareAvailability: () {
                          // TODO(someshubham): Add your Share callback
                          callShare(key.address.hex, snapshot.data!);
                        },
                      );
                    }),
              ],
            );
          }),
    );
  }
  Future<void> _launchUrl() async {
    Uri uri = Uri.parse("https://app.huddle01.com/tJIcKz");
    await launchUrl(uri);
  }
}
