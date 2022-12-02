import 'package:flutter/material.dart';
import 'package:flutter_calendar/config/images.dart';
import 'package:flutter_calendar/constants.dart';
import 'package:flutter_calendar/utils/crypto_utils.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:web3dart/web3dart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      SyncImage.avatar,
                    ),
                  ],
                ),
                [
                  "Hi ".text.caption(context).size(24).make(),
                  key.address
                      .toString()
                      .addressAbbreviation
                      .text
                      .size(24)
                      .textStyle(
                        const TextStyle(
                          decoration: TextDecoration.underline,
                          decorationStyle: TextDecorationStyle.dotted,
                        ),
                      )
                      .make(),
                ].row(crossAlignment: CrossAxisAlignment.end),
              ],
            );
          }),
    );
  }
}
