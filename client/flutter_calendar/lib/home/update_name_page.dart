// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_calendar/constants.dart';
import 'package:flutter_calendar/widgets/sync_button.dart';
import 'package:flutter_calendar/widgets/sync_toast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

class UpdateNamePage extends StatefulWidget {
  const UpdateNamePage({super.key});

  @override
  State<UpdateNamePage> createState() => _UpdateNamePageState();
}

class _UpdateNamePageState extends State<UpdateNamePage> with SyncToast {
  final userNameController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            12.heightBox,
            ListTile(
              title: "What are you known as?".text.size(24).semiBold.make(),
            ),
            8.heightBox,
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value.isEmptyOrNull) {
                  return "Empty Name";
                }
                return null;
              },
              controller: userNameController,
              decoration: InputDecoration(
                label: "Your name".text.make(),
                border: const OutlineInputBorder(),
              ),
            ).p12(),
            const Spacer(),
            SyncButton(
              label: "Save",
              onTap: () async {
                if ((formKey.currentState?.validate() ?? false)) {
                  // Save User name
                  final box = Hive.box(SyncConstant.userNameBox);
                  await box.put(
                      SyncConstant.userNameKey, userNameController.text);
                  // Navigate to home page and send back username
                  Navigator.pop(context);
                }
              },
            ),
            44.heightBox,
          ],
        ),
      ),
    );
  }
}
