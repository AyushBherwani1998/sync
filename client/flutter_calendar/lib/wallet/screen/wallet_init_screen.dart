import 'package:flutter/material.dart';
import 'package:flutter_calendar/config/sync_colors.dart';
import 'package:flutter_calendar/widgets/item_list.dart';
import 'package:flutter_calendar/widgets/sync_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

class WalletInitScreen extends StatefulWidget {
  const WalletInitScreen({Key? key}) : super(key: key);

  @override
  State<WalletInitScreen> createState() => _WalletInitScreenState();
}

class _WalletInitScreenState extends State<WalletInitScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: "Sync".text.size(40).make(),
            ),
          ),
          SyncButton(
            label: "Create new wallet",
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return ItemList<String>(
                    onItemSelect: (item) {},
                    itemList: [
                      Item(title: "Everyday"),
                      Item(title: "All days except weekends"),
                      Item(title: "Some days"),
                    ],
                    title: "What is your availability?",
                  );
                },
              ));
            },
            icon: const Icon(Icons.create),
          ),
          SyncButton(
            label: "Import wallet",
            icon: const Icon(
              Icons.import_export_sharp,
              color: SyncColor.primaryColor,
            ),
            textColor: SyncColor.primaryColor,
            bgColor: Colors.white,
            onTap: () {},
          ),
          const Divider().p8(),
          SyncButton(
            label: "Continue with Google",
            icon: const Icon(
              FontAwesomeIcons.google,
              color: SyncColor.primaryColor,
            ),
            textColor: SyncColor.primaryColor,
            bgColor: Colors.white,
            onTap: () {},
          ),
          40.heightBox,
        ],
      ),
    );
  }
}
