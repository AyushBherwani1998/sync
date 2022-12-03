import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_calendar/config/sync_colors.dart';
import 'package:flutter_calendar/constants.dart';
import 'package:flutter_calendar/home/guest/guest_home_page.dart';
import 'package:flutter_calendar/home/host/host_home_page.dart';
import 'package:flutter_calendar/wallet/wallet_manager.dart';
import 'package:flutter_calendar/widgets/sync_button.dart';
import 'package:flutter_calendar/widgets/sync_toast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

class ImportPrivateKeyScreen extends StatefulWidget {
  const ImportPrivateKeyScreen({super.key});

  @override
  State<ImportPrivateKeyScreen> createState() => _ImportPrivateKeyScreenState();
}

class _ImportPrivateKeyScreenState extends State<ImportPrivateKeyScreen>
    with SyncToast {
  final privateKeyController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();
  String? hostAddress;

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
              title: "Import your wallet".text.size(24).semiBold.make(),
            ),
            8.heightBox,
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value.isEmptyOrNull) {
                  return "Empty Private Key";
                }
                return null;
              },
              controller: privateKeyController,
              decoration: InputDecoration(
                label: "Enter your private key".text.make(),
                border: const OutlineInputBorder(),
              ),
            ).p12(),
            8.heightBox,
            TextButton.icon(
              onPressed: () async {
                final data = await Clipboard.getData("text/plain");
                privateKeyController.text = data?.text ?? "";
              },
              icon: const Icon(
                Icons.copy,
                color: SyncColor.primaryColor,
                size: 16,
              ),
              label: "Paste private key".text.size(14).make(),
            ),
            const Spacer(),
            SyncButton(
              label: "Import wallet",
              onTap: () async {
                if ((formKey.currentState?.validate() ?? false)) {
                  // Create Private Key
                  await WalletManager().importWalletFromPrivateKey(
                    key: privateKeyController.text,
                  );

                  // Navigate to home page
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      if (hostAddress == null) {
                        return const HostHomePage();
                      } else {
                        return const GuestHomePage();
                      }
                    }),
                  );
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
