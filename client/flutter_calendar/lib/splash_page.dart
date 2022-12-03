// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_calendar/constants.dart';
import 'package:flutter_calendar/home/guest/guest_home_page.dart';
import 'package:flutter_calendar/home/host/host_home_page.dart';
import 'package:flutter_calendar/wallet/screen/wallet_init_screen.dart';
import 'package:flutter_calendar/wallet/wallet_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uni_links/uni_links.dart';
import 'package:velocity_x/velocity_x.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      setState(() => _opacity = 1);
      Future.delayed(const Duration(seconds: 2)).then(
        (_) async {
          //listenForUri(context);
          final isFirstTimeUser = WalletManager().isFirstTimeUser();
          final url = await checkForShareUri();
          //"sync://address=0xD41dccEe35a0aBb7914A6b6A468395BBAeBD2cB0";
          await saveHostAddress(url);
          if (url?.isNotEmpty ?? false) {
            if (isFirstTimeUser) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) {
                  return const WalletInitScreen();
                }),
                (route) => false,
              );
            } else {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) {
                  return const GuestHomePage();
                }),
                (route) => false,
              );
            }
          } else {
            if (isFirstTimeUser) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) {
                  return const WalletInitScreen();
                }),
                (route) => false,
              );
            } else {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const HostHomePage(),
                ),
                (route) => false,
              );
            }
          }
        },
      );
    });
  }

  listenForUri(BuildContext context) {
    linkStream.listen((String? data) {
      print('got uri: $data');
      saveHostAddress(data);
      if (data?.isNotEmpty ?? false) {
        final isFirstTimeUser = WalletManager().isFirstTimeUser();
        if (isFirstTimeUser) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return const WalletInitScreen();
            }),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return const GuestHomePage();
            }),
          );
        }
      }
    }, onError: (Object err) {
      print('got err: $err');
    });
  }

  saveHostAddress(String? url) {
    final address = url?.split("=")[1];
    final box = Hive.box(SyncConstant.hostAddressBox);
    box.put(SyncConstant.hostAddressKey, address);
  }

  Future<String?> checkForShareUri() async {
    try {
      final initialLink = await getInitialLink();
      print("Initial URI: $initialLink");
      return initialLink;
    } on PlatformException {
      //handle error
      return null;
    }
  }

  double _opacity = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedOpacity(
          duration: const Duration(seconds: 1),
          opacity: _opacity,
          child: Hero(
            tag: 'SafaltaTextLogo',
            child: "Sync".text.size(40).make(),
          ),
        ),
      ),
    );
  }
}
