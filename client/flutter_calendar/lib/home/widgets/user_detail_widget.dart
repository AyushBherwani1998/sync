import 'package:flutter/material.dart';
import 'package:flutter_calendar/config/images.dart';
import 'package:flutter_calendar/constants.dart';
import 'package:flutter_calendar/ens/ens_resolver.dart';
import 'package:flutter_calendar/utils/crypto_utils.dart';
import 'package:flutter_calendar/widgets/avatar.dart';
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

  String get publicAddress {
    return privateKey.address.hex;
  }

  @override
  Widget build(BuildContext context) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(
            future: ENSResolver.getENS(publicAddress),
            builder: (context, snapshot) {
              return Avatar(ens: snapshot.data ?? publicAddress);
            },
          ),
        ],
      ),
      [
        "Hi, ".text.caption(context).size(24).make(),
        GestureDetector(
          onTap: onAddressTap,
          child: FutureBuilder(
            future: ENSResolver.getENS(publicAddress),
            builder: (context, snapshot) {
              late final String address;
              if (snapshot.hasData) {
                if (snapshot.data != null) {
                  address = snapshot.data!;
                } else {
                  address = publicAddress.addressAbbreviation;
                }
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                address = publicAddress.addressAbbreviation;
                return address.text
                    .size(24)
                    .textStyle(
                      const TextStyle(
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.dotted,
                      ),
                    )
                    .make()
                    .shimmer();
              } else {
                address = publicAddress.addressAbbreviation;
              }
              return ValueListenableBuilder(
                valueListenable:
                    Hive.box(SyncConstant.userNameBox).listenable(),
                builder: (context, box, _) {
                  final isUserNamePresent =
                      box.containsKey(SyncConstant.userNameKey);
                  if (!isUserNamePresent) {
                    box.put(SyncConstant.userNameKey, address);
                  }
                  return box
                      .get(SyncConstant.userNameKey)
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
                },
              );
            },
          ),
        ),
      ].row(crossAlignment: CrossAxisAlignment.end),
    ].column();
  }
}
