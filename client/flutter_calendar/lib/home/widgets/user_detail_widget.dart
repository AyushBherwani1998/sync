import 'package:flutter/material.dart';
import 'package:flutter_calendar/config/images.dart';
import 'package:flutter_calendar/constants.dart';
import 'package:flutter_calendar/utils/crypto_utils.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:web3dart/web3dart.dart';

class UserDetailWidget extends StatelessWidget {
  final EthPrivateKey privateKey;

  final VoidCallback onAddressTap;

  const UserDetailWidget({
    required this.privateKey,
    required this.onAddressTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            SyncImage.avatar,
          ),
        ],
      ),
      [
        "Hi, ".text.caption(context).size(24).make(),
        GestureDetector(
          onTap: onAddressTap,
          child: ValueListenableBuilder(
              valueListenable: Hive.box(SyncConstant.userNameBox).listenable(),
              builder: (
                context,
                Box userNameBox,
                value,
              ) {
                final userName = userNameBox.get(SyncConstant.userNameKey) ??
                    privateKey.address.toString().addressAbbreviation;

                return userName
                    .toString()
                    .text
                    .size(24)
                    .textStyle(
                      const TextStyle(
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.dotted,
                      ),
                    )
                    .make();
              }),
        ),
      ].row(crossAlignment: CrossAxisAlignment.end),
    ].column();
  }
}
