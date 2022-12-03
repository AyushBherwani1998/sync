import 'dart:math'; //used for the random number generator

import 'package:flutter_calendar/constants.dart';
import 'package:flutter_calendar/utils/crypto_utils.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:web3dart/web3dart.dart';

class WalletManager {
  EthPrivateKey? privateKey;

  Future<void> createWallet() async {
    var rng = Random.secure();
    privateKey = EthPrivateKey.createRandom(rng);
    await _savePrivateKey();
  }

  Future<void> importWalletFromPrivateKey({required String key}) async {
    privateKey = EthPrivateKey.fromHex(key);
    await _savePrivateKey();
  }

  EthPrivateKey getPrivateKey() {
    final box = Hive.box(SyncConstant.privateKeyBox);
    final privateKeyBytes = box.get(SyncConstant.privateKeyStorageKey);
    final key = EthPrivateKey.fromHex(bytesToHex(privateKeyBytes));
    return key;
  }

  Future<void> _savePrivateKey() async {
    final box = Hive.box(SyncConstant.privateKeyBox);
    await box.put(
      SyncConstant.privateKeyStorageKey,
      privateKey!.privateKey,
    );
  }
}
