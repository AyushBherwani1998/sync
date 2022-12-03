import 'dart:math'; //used for the random number generator

import 'package:flutter_calendar/constants.dart';
import 'package:flutter_calendar/utils/crypto_utils.dart';
import 'package:flutter_calendar/web3/sync/sync_contract.dart';
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

  EthPrivateKey getPrivateKey() {
    final box = Hive.box(SyncConstant.privateKeyBox);
    final privateKeyBytes = box.get(SyncConstant.privateKeyStorageKey);
    final key = EthPrivateKey.fromHex(bytesToHex(privateKeyBytes));
    return key;
  }

  Future<bool> removeAccount() async {
    final box = Hive.box(SyncConstant.privateKeyBox);
    final isCleared = await box.clear();
    return isCleared == 0;
  }

  String getUserAddress() {
    EthPrivateKey privateKey = getPrivateKey();
    return bytesToHex(privateKey.address.addressBytes);
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
