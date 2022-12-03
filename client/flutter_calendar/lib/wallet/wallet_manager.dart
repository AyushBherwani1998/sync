import 'dart:math'; //used for the random number generator

import 'package:flutter_calendar/constants.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:web3dart/web3dart.dart';

class WalletManager {
  EthPrivateKey? privateKey;
  final box = Hive.box(SyncConstant.privateKeyBox);

  Future<void> createWallet() async {
    var rng = Random.secure();
    privateKey = EthPrivateKey.createRandom(rng);
    await _savePrivateKey();
  }

  Future<void> importWalletFromPrivateKey({required String key}) async {
    privateKey = EthPrivateKey.fromHex(key);
    await _savePrivateKey();
  }

  Future<void> _savePrivateKey() async {
    await box.put(
      SyncConstant.privateKeyStorageKey,
      privateKey!.privateKey,
    );
  }

  bool isFirstTimeUser() {
    final isPrivateKeyPresent =
        box.containsKey(SyncConstant.privateKeyStorageKey);
    return !isPrivateKeyPresent;
  }
}
