import 'dart:math'; //used for the random number generator

import 'package:flutter_calendar/constants.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:web3dart/web3dart.dart';

class WalletManager {
  EthPrivateKey? privateKey;

  void createWallet() {
    var rng = Random.secure();
    privateKey = EthPrivateKey.createRandom(rng);
    _savePrivateKey();
  }

  void importWalletFromPrivateKey({required String key}) {
    privateKey = EthPrivateKey.fromHex(key);
    _savePrivateKey();
  }

  _savePrivateKey() {
    final box = Hive.box(SyncConstant.privateKeyBox);
    box.put(
      SyncConstant.privateKeyStorageKey,
      privateKey,
    );
  }
}
