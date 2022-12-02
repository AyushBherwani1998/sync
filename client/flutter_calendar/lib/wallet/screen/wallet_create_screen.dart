import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class WalletCreateScreen extends StatefulWidget {
  const WalletCreateScreen({Key? key}) : super(key: key);

  @override
  State<WalletCreateScreen> createState() => _WalletCreateScreenState();
}

class _WalletCreateScreenState extends State<WalletCreateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.import_export),
                  label: "Create Wallet".text.make(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
