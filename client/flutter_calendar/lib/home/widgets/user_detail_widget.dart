import 'package:flutter/material.dart';
import 'package:flutter_calendar/config/images.dart';
import 'package:flutter_calendar/utils/crypto_utils.dart';
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
          child: privateKey.address
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
        ),
      ].row(crossAlignment: CrossAxisAlignment.end),
    ].column();
  }
}
