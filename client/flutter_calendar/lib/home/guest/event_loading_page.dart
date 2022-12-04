import 'package:flutter/material.dart';
import 'package:flutter_calendar/config/sync_lottie.dart';
import 'package:flutter_calendar/constants.dart';
import 'package:flutter_calendar/utils/crypto_utils.dart';
import 'package:flutter_calendar/web3/sync/models/sync_event.dart';
import 'package:flutter_calendar/web3/web3_client.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

class EventLoadingPage extends StatefulWidget {
  final ValueChanged<BuildContext> onSuccess;
  final ValueChanged<BuildContext> onFailure;
  final String hash;

  const EventLoadingPage({
    Key? key,
    required this.onSuccess,
    required this.onFailure,
    required this.hash,
  }) : super(key: key);

  @override
  State<EventLoadingPage> createState() => _MeetingLoadingPageState();
}

class _MeetingLoadingPageState extends State<EventLoadingPage> {
  late String hostAddress;

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
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Lottie.asset(SyncLottie.loader, height: 200).centered(),
    );
  }
}
