import 'package:flutter/material.dart';
import 'package:flutter_calendar/config/sync_colors.dart';
import 'package:flutter_calendar/wallet/wallet_manager.dart';
import 'package:flutter_calendar/widgets/sync_button.dart';
import 'package:flutter_calendar/widgets/sync_toast.dart';
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
              onPressed: () {},
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
              onTap: () {
                if ((formKey.currentState?.validate() ?? false)) {
                  // Create Private Key
                  WalletManager().importWalletFromPrivateKey(
                    key: privateKeyController.text,
                  );

                  //Navigate to home page
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
