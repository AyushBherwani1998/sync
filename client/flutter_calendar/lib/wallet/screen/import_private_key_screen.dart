import 'package:flutter/material.dart';
import 'package:flutter_calendar/config/sync_colors.dart';
import 'package:flutter_calendar/widgets/sync_button.dart';
import 'package:velocity_x/velocity_x.dart';

class ImportPrivateKeyScreen extends StatefulWidget {
  const ImportPrivateKeyScreen({super.key});

  @override
  State<ImportPrivateKeyScreen> createState() => _ImportPrivateKeyScreenState();
}

class _ImportPrivateKeyScreenState extends State<ImportPrivateKeyScreen> {
  final privateKeyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          12.heightBox,
          ListTile(
            title: "Import your wallet".text.size(24).semiBold.make(),
          ),
          8.heightBox,
          TextField(
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
            onTap: () {},
          ),
          44.heightBox,
        ],
      ),
    );
  }
}
