import 'package:flutter/material.dart';
import 'package:flutter_calendar/constants.dart';
import 'package:flutter_calendar/home/guest/meeting_confirmation_page.dart';
import 'package:flutter_calendar/home/guest/meeting_loading_page.dart';
import 'package:flutter_calendar/utils/crypto_utils.dart';
import 'package:flutter_calendar/web3/sync/models/sync_event.dart';
import 'package:flutter_calendar/web3/sync/sync_contract.dart';
import 'package:flutter_calendar/widgets/sync_button.dart';
import 'package:flutter_calendar/widgets/sync_toast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

class MeetingCreationPage extends StatefulWidget {
  final DateTime dateTime;
  final SyncEvent event;
  const MeetingCreationPage({
    required this.dateTime,
    required this.event,
    Key? key,
  }) : super(key: key);

  @override
  State<MeetingCreationPage> createState() => _MeetingCreationPageState();
}

class _MeetingCreationPageState extends State<MeetingCreationPage> {
  final nameController = TextEditingController();
  final agendaController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();

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
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
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
                              "${DateFormat('MMMd').format(widget.dateTime)}   •   ${DateFormat('jm').format(widget.dateTime)}   •   ${widget.event.timeSlot}mins"
                                  .text
                                  .size(20)
                                  .semiBold
                                  .make()
                                  .p12(),
                              "with ${hostAddress.toString().addressAbbreviation}"
                                  .text
                                  .caption(context)
                                  .size(16)
                                  .make()
                                  .pOnly(left: 12, bottom: 12),
                            ],
                          ),
                        ).p12(),
                      ),
                    ],
                  ),
                  "Name this sync-up".text.semiBold.size(26).make().p12(),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value.isEmptyOrNull) {
                        return "Empty Name";
                      }
                      return null;
                    },
                    controller: nameController,
                    decoration: InputDecoration(
                      label: "Your name".text.make(),
                      border: const OutlineInputBorder(),
                    ),
                  ).p12(),
                  "Any agenda for the sync up?"
                      .text
                      .semiBold
                      .size(26)
                      .make()
                      .p12(),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value.isEmptyOrNull) {
                        return "Empty Agenda";
                      }
                      return null;
                    },
                    controller: agendaController,
                    decoration: InputDecoration(
                      label: "Agenda".text.make(),
                      border: const OutlineInputBorder(),
                    ),
                  ).p12(),
                ],
              ),
            ),
            SyncButton(
              label: "Confirm",
              onTap: () async {
                final hash = await SyncContract.scheduleMeeting(
                  title: nameController.text,
                  description: agendaController.text,
                  startTimeStamp: widget.dateTime.millisecondsSinceEpoch,
                  endTimeStamp: widget.dateTime
                      .add(
                        Duration(minutes: widget.event.timeSlot),
                      )
                      .millisecondsSinceEpoch,
                  host: hostAddress,
                );

                if (hash.isEmptyOrNull) {
                  SyncToast.showErrorToast(
                    context,
                    "Unable to schedule a meeting",
                  );
                  context.pop();
                  return;
                }

                // ignore: use_build_context_synchronously
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return MeetingLoadingPager(
                      dateTime: widget.dateTime,
                      event: widget.event,
                      title: nameController.text,
                      hash: hash!,
                      onSuccess: (value) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return MeetingConfirmationPage(
                                dateTime: widget.dateTime,
                                event: widget.event,
                                title: nameController.text,
                              );
                            },
                          ),
                        );
                      },
                      onFailure: (value) {},
                    );
                  }),
                );
              },
            ),
            24.heightBox,
          ],
        ),
      ),
    );
  }
}
