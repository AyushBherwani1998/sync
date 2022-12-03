import 'package:flutter/material.dart';
import 'package:flutter_calendar/home/guest/meeting_confirmation_page.dart';
import 'package:flutter_calendar/widgets/sync_button.dart';
import 'package:velocity_x/velocity_x.dart';

class MeetingCreationPage extends StatefulWidget {
  final DateTime dateTime;
  final String time;
  const MeetingCreationPage({
    required this.dateTime,
    required this.time,
    Key? key,
  }) : super(key: key);

  @override
  State<MeetingCreationPage> createState() => _MeetingCreationPageState();
}

class _MeetingCreationPageState extends State<MeetingCreationPage> {
  final nameController = TextEditingController();
  final agendaController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();

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
                              "7th May   •   9:30 PM   •   30mins"
                                  .text
                                  .size(20)
                                  .semiBold
                                  .make()
                                  .p12(),
                              "with ayush.eth"
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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const MeetingConfirmationPage();
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
