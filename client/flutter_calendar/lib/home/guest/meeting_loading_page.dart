import 'package:flutter/material.dart';
import 'package:flutter_calendar/config/sync_lottie.dart';
import 'package:flutter_calendar/web3/web3_client.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

class MeetingLoadingPager extends StatefulWidget {
  final ValueChanged<BuildContext> onSuccess;
  final ValueChanged<BuildContext> onFailure;
  final String hash;

  const MeetingLoadingPager(
      {Key? key,
        required this.onSuccess,
        required this.onFailure,
        required this.hash
      })
      : super(key: key);

  @override
  State<MeetingLoadingPager> createState() =>
      _MeetingLoadingPageState();
}

class _MeetingLoadingPageState extends State<MeetingLoadingPager> {

  @override
  void initState() {
    super.initState();
    Web3ClientDart.executeTransactionStatusCheck(widget.hash).then((value) {
      if (value) {
        widget.onSuccess(context);
      } else {
        widget.onFailure(context);
      }
    }).catchError((e) {
      widget.onFailure(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          52.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(SyncLottie.loader, height: 200),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.white.withOpacity(0.2),
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      "Ayush <> ETHFinalist"
                          .text
                          .semiBold
                          .size(24)
                          .make()
                          .p12(),
                      "with ayush.eth"
                          .text
                          .caption(context)
                          .size(16)
                          .make()
                          .pOnly(
                        left: 12,
                        top: 12,
                        bottom: 12,
                      ),
                      "7th May   •   9:30 PM   •   30mins"
                          .text
                          .size(20)
                          .semiBold
                          .caption(context)
                          .make()
                          .p12(),
                    ],
                  ),
                ).p12(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
