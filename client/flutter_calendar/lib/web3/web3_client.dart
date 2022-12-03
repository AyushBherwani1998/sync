import 'dart:async';

import 'package:dartx/dartx.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

mixin Web3ClientDart {
  static final client = Web3Client(
    "https://goerli.infura.io/v3/36229aa90d54478bb93614edd05f06b0",
    Client(),
  );

  static Future<bool> executeTransactionStatusCheck(String? hash) async {
    final status = await checkTxStatus(hash);

    if (status != null) {
      if (status) {
        return status;
      } else {
        throw Exception("Something went wrong");
      }
    } else {
      throw Exception("Something went wrong");
    }
  }

  static Future<bool?> checkTxStatus(String? hash) async {
    bool isTimeUp = false;
    Timer(const Duration(minutes: 2), () => isTimeUp = true);
    if (isTimeUp) {
      return null;
    }
    final res = await client.getTransactionReceipt(hash.orEmpty());
    if (res?.status == true) {
      return res?.status;
    } else {
      await Future.delayed(const Duration(seconds: 3));
      return await checkTxStatus(hash);
    }
  }

}
